Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUFOIhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUFOIhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 04:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUFOIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 04:37:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264954AbUFOIhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 04:37:12 -0400
Date: Tue, 15 Jun 2004 04:36:51 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Does exec-shield with -fpie  work?
Message-ID: <20040615083649.GG21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1087286723.3156.35.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087286723.3156.35.camel@pc-16.office.scali.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 10:05:23AM +0200, Terje Eggestad wrote:
> te pc-16 ~ 70> !gcc
> gcc -fPIE -fpic -o ./testsc ./testsc.c

This is not a command to build a PIE.
You need
gcc -fpie -pie -o ./testsc ./testsc.c
instead (or s/-fpie/-fPIE/).

Furthermore, I don't think lkml is the right mailing list to ask about this.

	Jakub
