Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSGQRUy>; Wed, 17 Jul 2002 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSGQRUy>; Wed, 17 Jul 2002 13:20:54 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:17900 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S315456AbSGQRUx>;
	Wed, 17 Jul 2002 13:20:53 -0400
Date: Wed, 17 Jul 2002 19:23:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: close return value
Message-ID: <20020717172351.GB1352@win.tue.nl>
References: <20020716.180521.57640174.davem@redhat.com> <Pine.LNX.4.44.0207161817560.4794-100000@home.transmeta.com> <20020717115125.GD28284@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717115125.GD28284@merlin.emma.line.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 01:51:25PM +0200, Matthias Andree wrote:

> non-issue, since EAGAIN would violates the specs that don't list EGAIN

"Implementations may support additional errors not included in this
list, may generate errors included in this list under circumstances
other than those described here, or may contain extensions or
limitations that prevent some errors from occurring. The ERRORS
section on each reference page specifies whether an error shall be
returned, or whether it may be returned. Implementations shall not
generate a different error number from the ones described here for
error conditions described in this volume of IEEE Std 1003.1-2001, but
may generate additional errors unless explicitly disallowed for a
particular function."


Not listing an error in the spec does not mean it cannot occur.
Especially EFAULT is not usually listed.

Andries
