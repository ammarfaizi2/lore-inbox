Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292137AbSBAX1x>; Fri, 1 Feb 2002 18:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292136AbSBAX1d>; Fri, 1 Feb 2002 18:27:33 -0500
Received: from adsl-63-197-0-76.dsl.snfc21.pacbell.net ([63.197.0.76]:17167
	"HELO www.pmonta.com") by vger.kernel.org with SMTP
	id <S292135AbSBAX1Y>; Fri, 1 Feb 2002 18:27:24 -0500
From: Peter Monta <pmonta@pmonta.com>
To: hpa@zytor.com
Cc: garzik@havoc.gtf.org, linux-kernel@vger.kernel.org
In-Reply-To: <3C5B1CBB.6080802@zytor.com> (hpa@zytor.com)
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <20020201153346.B2497@havoc.gtf.org> <20020201205605.ED5111C5@www.pmonta.com> <3C5B1CBB.6080802@zytor.com>
Message-Id: <20020201232723.12F3E1C5@www.pmonta.com>
Date: Fri,  1 Feb 2002 15:27:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The point with the tests that have been mentioned is to derive such a
> conservative estimate, and to raise a red flag if the output suddenly
> becomes predictable.

Ah, I see; I was misled by the "truly random" remark, sorry.  So a reasonable
sanity test for a block of audio samples might be a standard deviation
greater than a few LSB; this will catch constant or close-to-constant
output.
