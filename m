Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268731AbTBZMcX>; Wed, 26 Feb 2003 07:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268735AbTBZMcX>; Wed, 26 Feb 2003 07:32:23 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:29091 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268731AbTBZMcW>; Wed, 26 Feb 2003 07:32:22 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] remove mod_inc_use_count from lec
Date: Wed, 26 Feb 2003 13:42:19 +0100
User-Agent: KMail/1.5
References: <200302261230.h1QCUox9003790@locutus.cmf.nrl.navy.mil>
In-Reply-To: <200302261230.h1QCUox9003790@locutus.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302261342.20282.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 February 2003 13:30, chas williams wrote:
> this patch removes the deprecated MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
> from the lane client.

Woah!  Shouldn't you add some try_module_get calls in the atm device handling routines first?

All the best,

Duncan.
