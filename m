Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWGJKRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWGJKRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGJKRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:17:16 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:32677 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S932311AbWGJKRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:17:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=mWlazK2XwuIksLgF+Cl9lCBLx68SSuNrQFtlvkaUgRFjRDtm8Cs43b47yf7B2J/QSC5u/8+ysg6F5biCAcxyQ4hKnWq0BCsGnqz9wUo6rBwVOYzd5PvEIe5Vl3zx8sWKkze0vCJ59JAegx75z/ZFmIPr6e+pvRKDnAIlvbfnC7Y=;
Date: Mon, 10 Jul 2006 14:16:14 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       devel@openvz.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] struct file leakage
Message-ID: <20060710101614.GA834@ms2.inr.ac.ru>
References: <44B2185F.1060402@sw.ru> <20060710030526.fdb1ca27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710030526.fdb1ca27.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I don't understand this.  Are you implying that there are other bugs.

Yes. I still see leakage of another objects, most likely fdtables.
Probably, it is an internal bleeding of openvz or it was already fixed
in mainstreem. I still do not know.

Alexey
