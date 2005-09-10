Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVIJNEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVIJNEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIJNEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:04:37 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:53740 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750808AbVIJNEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:04:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rWSNAJEWHk6PFIA7RZr0SAveopZw5JTiC4Za4GbN064l0WPAUcGSEHndYTmMnByiy5Vtre3DHBCS7avN8p9TxKiNUOqcd+KTBq0qlCARaPUzfU0al7TScSPNkEJ4LeaEa/NaZoDEOTeVQiN/KmAvmvxW8GVoys2ueAVAUlVYIFk=
Message-ID: <21d7e9970509100604244f489@mail.gmail.com>
Date: Sat, 10 Sep 2005 23:04:28 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: airlied@gmail.com
To: Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: 2.6.13: kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050910120252.GA31522@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050910120252.GA31522@janus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sep 10 13:55:37 iapetus kernel: [drm] Initialized drm 1.0.0 20040925
> Sep 10 13:55:37 iapetus kernel: [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]
> 
> Starting Xorg:
> Sep 10 13:56:14 iapetus kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> Sep 10 13:56:14 iapetus kernel: [drm:drm_unlock] *ERROR* Process 2170 using kernel context 0
> 

Your missing your AGP backend.... its either not compiled in or not
being loaded before  the drm..

Dave.
