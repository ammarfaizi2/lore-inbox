Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSJWUBJ>; Wed, 23 Oct 2002 16:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbSJWUBI>; Wed, 23 Oct 2002 16:01:08 -0400
Received: from fmr02.intel.com ([192.55.52.25]:9959 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265187AbSJWUBH>; Wed, 23 Oct 2002 16:01:07 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758C30@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Rob Rhoads'" <errhoads@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [BUG] e100 driver fails to initialize NIC on 2.5.44
Date: Wed, 23 Oct 2002 13:07:12 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Rhoads wrote:
> -#define E100_MAX_SCB_WAIT	100	/* Max udelays in wait_scb */
> +#define E100_MAX_SCB_WAIT	2000	/* Max udelays in wait_scb */

I'm not in favor of increasing a hardware timeout value 20x without knowing
root-cause of the failure.  What is unique about your environment?  I'd like
to know if there are others out there that have run into this same failure.
List?

-scott
