Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUBXQKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUBXQIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:08:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262198AbUBXQFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:05:23 -0500
Date: Tue, 24 Feb 2004 11:05:41 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Ian Soboroff <ian.soboroff@nist.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why are 2.6 modules so huge?
In-Reply-To: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
Message-ID: <Xine.LNX.4.44.0402241105070.24791-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Ian Soboroff wrote:

> 
> Can anyone help me understand why 2.6-series kernel modules are so
> huge?
> 
> $ cd /lib/modules
> $ ls -l */kernel/fs/vfat
> 2.4.20-18.8bigmem/kernel/fs/vfat:
> total 20
> -rw-r--r--    1 root     root        17678 May 29  2003 vfat.o

You should use size(1) for this purpose, instead of ls.


- James
-- 
James Morris
<jmorris@redhat.com>


