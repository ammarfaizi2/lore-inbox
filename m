Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276661AbRJKSWL>; Thu, 11 Oct 2001 14:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276654AbRJKSWB>; Thu, 11 Oct 2001 14:22:01 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:41565 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S276673AbRJKSVu>;
	Thu, 11 Oct 2001 14:21:50 -0400
Message-ID: <20011011202242.A7283@win.tue.nl>
Date: Thu, 11 Oct 2001 20:22:42 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <Pine.GSO.4.21.0110110106070.21168-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0110110106070.21168-100000@weyl.math.psu.edu>; from Alexander Viro on Thu, Oct 11, 2001 at 01:07:22AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 01:07:22AM -0400, Alexander Viro wrote:

> If you have sfdisk, sfdisk /dev/sda -O /tmp/foo + mailing the result would
> make debugging the thing much simpler (that one - from the 2.4.10).

Probably you mean sfdisk -d /dev/sda > /tmp/foo or so?
My favourite tends to be sfdisk -l -uS -x /dev/sda

The -O option saves the sectors that are changed by the sfdisk call
to some file, so that a later undo is possible.

Andries
