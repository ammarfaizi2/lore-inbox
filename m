Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWEOLmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWEOLmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWEOLmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:42:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:52386 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964891AbWEOLmt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:42:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sWs5kh/yFc8uPdNWaVnGDy1qMv3dA3EKprm3MWIn2OikADcVCCeIsqHXc32Gint8Cp5r+7K5S9DxU8yHKcKbCsYSapxDGB9PKhY1r8/3w/sHyTFhfvXQ0QJ9kQmJaSpjXIw7D1O16V7F+szdimau646K98UYU3JuUmt6KZJPrmw=
Message-ID: <84144f020605150442t27ac78c2qfb6c5dd777d9935a@mail.gmail.com>
Date: Mon, 15 May 2006 14:42:48 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Cc: "Eric Dumazet" <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060515040358.5e24549d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515005637.00b54560.akpm@osdl.org>
	 <4468534A.3060604@cosmosbay.com>
	 <20060515040358.5e24549d.akpm@osdl.org>
X-Google-Sender-Auth: de6bb1ca757b53d3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Eric Dumazet <dada1@cosmosbay.com> wrote:
> > It seems latest kernels have a problem in kmem_cache_destroy()

On 5/15/06, Andrew Morton <akpm@osdl.org> wrote:
> Mainline, or just -mm?

Could be in mainline. See the following thread:
http://lkml.org/lkml/2006/4/27/69. Can't reproduce locally so waiting
for git bisect results from the original reporter...

                                     Pekka
