Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUKCI6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUKCI6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUKCI6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:58:45 -0500
Received: from main.gmane.org ([80.91.229.2]:735 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261479AbUKCI6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:58:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: still no cd/dvd burning as user with 2.6.9
Date: Wed, 03 Nov 2004 13:59:37 +0500
Message-ID: <cma6j6$kbk$1@sea.gmane.org>
References: <41889857.5040506@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217.148.52.177
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:

> I use 2.6.9-ac3 on my Laptop and I just wanted to burn a DVD-Video with
> my external Pioneer DVD writer which is connected via fire-wire to the
> Laptop.

Make sure that cdrecord (or the analogous DVD burning utility) is NOT setuid
root and that you (as a user) have the write permission for the writer
device node.

-- 
Alexander E. Patrakov

