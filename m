Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVJSEUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVJSEUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 00:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVJSEUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 00:20:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9866 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750829AbVJSEUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 00:20:04 -0400
Subject: Re: large files unnecessary trashing filesystem cache?
From: Lee Revell <rlrevell@joe-job.com>
To: Guido Fiala <gfiala@s.netic.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510182201.11241.gfiala@s.netic.de>
References: <200510182201.11241.gfiala@s.netic.de>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 00:10:00 -0400
Message-Id: <1129695001.8910.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
> Of course one could always implement f_advise-calls in all
> applications

Um, this seems like the obvious answer.  The application doing the read
KNOWS it's a streaming read, while the best the kernel can do is guess.

You don't really make much of a case that fadvise can't do the job.

Lee

