Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTBUQ5Q>; Fri, 21 Feb 2003 11:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbTBUQ5Q>; Fri, 21 Feb 2003 11:57:16 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:48319 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267581AbTBUQ5P>;
	Fri, 21 Feb 2003 11:57:15 -0500
Date: Fri, 21 Feb 2003 17:19:29 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH TRIVIAL] forgotten include in char/epca.c
Message-ID: <20030221171929.GA25704@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <Pine.LNX.4.51.0302211745450.1303@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0302211745450.1303@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 05:56:24PM +0100, Maciej Soltysiak wrote:

 > this simple patch eliminates gcc warnings in epca.c:

This 'fixes' things temporarily for UP, but is completely broken on SMP.
cli/sti and friends are long since dead (2.5.28).

See Documentation/cli-sti-removal.txt

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
