Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTFIUMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTFIUMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:12:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64903 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261169AbTFIUMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:12:18 -0400
Date: Mon, 09 Jun 2003 13:14:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.70-mm6
Message-ID: <64000000.1055189666@flay>
In-Reply-To: <1055189322.600.1.camel@teapot.felipe-alfaro.com>
References: <20030607151440.6982d8c6.akpm@digeo.com> <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv> <46580000.1055180345@flay> <Pine.LNX.4.51.0306092017390.25458@dns.toxicfilms.tv> <51250000.1055184690@flay> <1055189322.600.1.camel@teapot.felipe-alfaro.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, June 09, 2003 22:08:42 +0200 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> On Mon, 2003-06-09 at 20:51, Martin J. Bligh wrote:
>> >> If you don't nice the hell out of X, does it work OK?
>> > No.
>> > 
>> > The way I reproduce the sound skips:
>> > run xmms, run evolution, compose a mail with gpg.
>> > on mm6 the gpg part stops the sound for a few seconds. (with X -10 and 0)
>> > on mm5 xmms plays without stops. (with X -10)
>> 
>> Does this (from Ingo?) do anything useful to it?
> 
> I can confirm that 2.5.70-mm6 with Ingo's patch and HZ set back to 1000
> is nearly perfect (it still takes some seconds for the scheduler to
> adjust dynamic priorities).

OK ... sorry to be pedantic, but I want to nail this down.
It's still broken with HZ=1000, but without Ingo's patch, right?

M.

