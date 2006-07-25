Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWGYONH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWGYONH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWGYONH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:13:07 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22189 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932164AbWGYONG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:13:06 -0400
Date: Tue, 25 Jul 2006 17:13:05 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: aia21@cantab.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: ntfs: remove unnecessary PG_uptodate check from ntfs_readpage
In-Reply-To: <Pine.LNX.4.64.0607251500480.2372@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0607251711380.4390@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607251542570.2665@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0607251500480.2372@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Anton Altaparmakov wrote:
> Please do not apply this patch or you will see metadata corruption on 
> NTFS.
> 
> Pekka, given there is a comment saying why this check is necessary, I 
> really do not understand how you can claim that it is not...

Sorry Anton, that's just me being confused, I guess... I don't see you 
dropping page lock in ntfs_writepage so how does that happen then? Thanks.

					Pekka
