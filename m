Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSKFSTd>; Wed, 6 Nov 2002 13:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSKFSTd>; Wed, 6 Nov 2002 13:19:33 -0500
Received: from [64.76.155.18] ([64.76.155.18]:5768 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S265885AbSKFSTc>;
	Wed, 6 Nov 2002 13:19:32 -0500
Date: Wed, 6 Nov 2002 15:25:58 -0300 (CLST)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I'm still getting oops when loading eth modules (e100,
 eepro100 and tulip)
In-Reply-To: <20021106181645.GA4600@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0211061524050.12033-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, bert hubert wrote:

> On Wed, Nov 06, 2002 at 02:59:02PM -0300, Robinson Maureira Castillo wrote:
> > Hi all,
> > I'm still getting this oops, I've setup a page with all information, it's 
> > located at <http://alumno.inacap.cl/~rmaureira/kernel/oops/>
> 
> Are you very very sure that you are using the same compiler to compile the
> kernel and the modules? With the same settings? It is not guaranteed to work
> otherwise.
> 
> Did you compile the kernel and the modules yourself?
> 
> Regards,
> 
> bert
> 
> 

Completely sure, I'm using gcc 3.2 (rh 8.0 version) in ws01, and 2.96 (rh 
7.2 version) in elekid. I proceed like this:

bk clone/pull/co 
make defconfig
make menuconfig
make modules modules_install install
reboot

-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

