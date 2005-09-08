Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVIHOCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVIHOCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVIHOCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:02:42 -0400
Received: from mailfe09.tele2.se ([212.247.155.1]:54246 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751358AbVIHOCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:02:41 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Thu, 8 Sep 2005 16:02:35 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange LVM2/DM data corruption with 2.6.11.12
Message-ID: <20050908140235.GB2746@localhost.localdomain>
References: <43200B5E.90401@linbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43200B5E.90401@linbox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 11:58:54AM +0200 Ludovic Drolez wrote:

> Hi !
> 
> We are developing (GPLed) disk cloning software similar to partimage: it's 
> an intelligent 'dd' which backups only used sectors.
> 
> Recently I added LVM1/2 support to it, and sometimes we saw LVM 
> restorations failing randomly (Disk images are not corrupted, but the 
> result of the restoration can be lead to a corrupted filesystem). If a 
> restoration fails, just try another one and it will work...
> 

Please upgrade to 2.6.12.6 (I don't remember exactly in which
2.6.12.x it went in), it contains a bugfix that should fix what
you are seeing. 2.6.13 also has this.
