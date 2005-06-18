Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVFRNMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVFRNMd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 09:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVFRNMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 09:12:33 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:59935 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262111AbVFRNMc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 09:12:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fNSDehiu8O0Y02bvym04t5pFYFlOupATZNz6cUICZY6j3o2DfcfMYNUfYXylOjmMOAwybGfbogAruK73BTH9LhQ5BTR4AuxFAhCFmKjAnehv/vUk4veX3UT1A83ihpgO28U0ArkOFi9RBuAD3UBPxX17L1XKIJTgpF7d6KF2ABs=
Message-ID: <cc27d5b10506180612177415c6@mail.gmail.com>
Date: Sat, 18 Jun 2005 15:12:29 +0200
From: Paolo Marchetti <natryum@gmail.com>
Reply-To: Paolo Marchetti <natryum@gmail.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12 cpu-freq conservative governor problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello world,
I'm trying the brand new conservative governor on my p4 2.66 laptop
("Intel Pentium 4 clock modulation" only), it doesn't work at all (my
cpu does not scale).

cat cpufreq/conservative/sampling_rate_max 
2755359744

cat cpufreq/scaling_max_freq 
2666600

I don't get this...
ondemand governor works fine as usual.
