Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTDNNg1 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTDNNgN (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:36:13 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:24794 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263241AbTDNNfD (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 09:35:03 -0400
Date: Mon, 14 Apr 2003 07:46:47 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Alex Adriaanse <alex_a@caltech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFS-Lock patch
In-Reply-To: <JIEIIHMANOCFHDAAHBHOAECGDAAA.alex_a@caltech.edu>
Message-ID: <Pine.LNX.4.44.0304140742440.22450-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Alex Adriaanse wrote:

> Hi,
> 
> I'm just curious, is there any reason why the VFS-lock patch provided by the
> LVM people has not been included into the 2.4.x tree yet?
> 
> If I were to apply this patch to a stock 2.4.20 kernel, is it safe to use
> LVM snapshots with ReiserFS on production machines, or are there any
> stability issues with it (either with the LVM version that comes with
> 2.4.20, or upgrading to LVM 1.0.7)?

Hi,
We have been using this in production for some time, with all the 2.4
kernels since 2.4.17 and it has been stable.  Our version is at

http://www.hardrock.org/kernel/2.4.20

You will have to follow the patch-order file and make sure to apply the ext3
patch first as it will be required to use the LVM patch.

BTW, we are still using LVM version 1.0.5.

Regards
James Bourne

> Thanks,
> 
> Alex

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

