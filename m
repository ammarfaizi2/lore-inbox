Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTLPUJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTLPUJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:09:49 -0500
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:24079 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S261909AbTLPUJs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:09:48 -0500
From: Witold Krecicki <adasi@kernel.pl>
To: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Date: Tue, 16 Dec 2003 21:09:36 +0100
User-Agent: KMail/1.5.93
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws>
In-Reply-To: <20031216040156.GJ12726@pegasys.ws>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312162109.36672.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Tuesday 16 of December 2003 05:01, jw schultz napisa³:
> No Linux [R]AID improves sequential performance.  How would
> reading 65KB from two disks in alternation be faster than
> reading continuously from one disk?
Well, but at the beginning I've got about 85-90MB/sec for buffered array 
reads. That was on 2.4.21-pre or even patched 2.4.20 (on siimage - in it's 
early stages, not sata_sil driver). Now it's 3 times slower (checkedwith 
preemptible kernel, it's even slower) - so something went bad.
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
