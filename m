Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTEUXTC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTEUXTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:19:02 -0400
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:11197 "HELO
	fargo") by vger.kernel.org with SMTP id S262356AbTEUXTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:19:01 -0400
Date: Thu, 22 May 2003 01:37:07 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Anton Petrusevich <casus@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e100 & 2.4.20
Message-ID: <20030521233707.GB20622@fargo>
Mail-Followup-To: Anton Petrusevich <casus@mail.ru>,
	linux-kernel@vger.kernel.org
References: <20030521163804.GA7957@casus.home.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030521163804.GA7957@casus.home.my>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

> This is an updated RedHat kernel for rh72, with
> Intel(R) PRO/100 Network Driver - version 2.2.21-k1
> Copyright (c) 2003 Intel Corporation

I have the same problems with a stock 2.4.20 kernel. As Scott Feldman suggested,
disabling hardware receive checksums is a temporary solution. Load the e100
driver with the parameter XsumRX=0 to disable it.

> I just don't like it. Is it a known problem with e100?

I also didn't like it ;)), csum errors never sound good ;).

Bye,

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
