Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281678AbRLLSBI>; Wed, 12 Dec 2001 13:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281719AbRLLSAr>; Wed, 12 Dec 2001 13:00:47 -0500
Received: from fungus.teststation.com ([212.32.186.211]:4880 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S281678AbRLLSAl>; Wed, 12 Dec 2001 13:00:41 -0500
Date: Wed, 12 Dec 2001 19:00:33 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: "Eshwar D - CTD, Chennai." <deshwar@ctd.hcltech.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problem SMBFS
In-Reply-To: <EF836A380096D511AD9000B0D021B5273EFC6F@narmada.ctd.hcltech.com>
Message-ID: <Pine.LNX.4.33.0112121857220.4034-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Eshwar D - CTD, Chennai. wrote:

> 	When i read a file xyz (file is in smbfs mounted directory) from one
> client and i am didn't closed, from second client i written some data using
> write system call and closed xyz file,  i am not see the data from client
> one. Then i closed file in client one and tried to read the data, same thing
> is continuing. Can any one suggest me is this is the property of smbfs. I am
> not a member in mailing list please send me u r request to my mail id

Kernel version? This sounds a lot like a problem fixed sometime around
2.2.18 where smbfs didn't consider certain files as changed.

Are both clients smbfs?

/Urban

