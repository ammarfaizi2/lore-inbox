Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTF3IBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 04:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTF3IBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 04:01:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55483 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265375AbTF3IBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 04:01:46 -0400
Date: Mon, 30 Jun 2003 09:16:06 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Trying to improve /proc/filesystems
Message-ID: <20030630081606.GN27348@parcelfarce.linux.theplanet.co.uk>
References: <D9B4591FDBACD411B01E00508BB33C1B01405371@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01405371@mesadm.epl.prov-liege.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 09:55:45AM +0200, Frederick, Fabian wrote:
> Alexander,
> 
> 	Why don't we have centralized /proc/filesystems access ? 2 fields
> file for fs can't be a standard

"Centralized"?  In which sense?  Any shell script might be using that
animal and expect the format to remain stable.
