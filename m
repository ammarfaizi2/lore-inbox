Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUHGNTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUHGNTF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 09:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUHGNTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 09:19:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28289 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262085AbUHGNTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 09:19:03 -0400
Date: Sat, 7 Aug 2004 14:18:29 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Amon Ott <ao@rsbac.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel file offset pointer races
Message-ID: <20040807131825.GE12308@parcelfarce.linux.theplanet.co.uk>
References: <20040804214056.6369.0@argo.troja.mff.cuni.cz> <1091796995.16306.20.camel@localhost.localdomain> <200408071438.18878.ao@rsbac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408071438.18878.ao@rsbac.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 02:38:12PM +0200, Amon Ott wrote:
> Would it not be useful to have per-process or per-thread offsets? Do 
> parallel processes really need to share the offset?
> 
> E.g., the struct file could (optionally) be copied on fork with 
> copy-on-write to avoid extra memory consumption.

(cat a; cat b) > /tmp/foo
