Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTBGAFI>; Thu, 6 Feb 2003 19:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTBGAFI>; Thu, 6 Feb 2003 19:05:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65029 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267613AbTBGAFH>; Thu, 6 Feb 2003 19:05:07 -0500
Date: Fri, 7 Feb 2003 00:14:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: niteowl@intrinsity.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 kernel bugs
Message-ID: <20030207001443.B19306@flint.arm.linux.org.uk>
Mail-Followup-To: niteowl@intrinsity.com, linux-kernel@vger.kernel.org
References: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>; from niteowl@intrinsity.com on Thu, Feb 06, 2003 at 02:43:17PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 02:43:17PM -0600, niteowl@intrinsity.com wrote:
> ===== misplaced/extra semicolon =====
> sound/oss/vidc.c:228			for (new2size = 128; new2size < newsize; new2size <<= 1);

Style bug, but functionality is intended as written.  I'll probably be
lazy with this one; OSS drivers should be converted to ALSA at some
point in the future, so I don't consider this a high priority thing
to fix at present.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

