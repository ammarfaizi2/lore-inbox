Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRCEOzg>; Mon, 5 Mar 2001 09:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCEOz0>; Mon, 5 Mar 2001 09:55:26 -0500
Received: from mail630.gsfc.nasa.gov ([128.183.190.39]:29713 "EHLO
	mail630.gsfc.nasa.gov") by vger.kernel.org with ESMTP
	id <S129318AbRCEOzP>; Mon, 5 Mar 2001 09:55:15 -0500
Date: Mon, 5 Mar 2001 09:55:12 -0500
From: John Kodis <kodis@mail630.gsfc.nasa.gov>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010305095512.A30787@tux.gsfc.nasa.gov>
Mail-Followup-To: John Kodis <kodis@mail630.gsfc.nasa.gov>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org, bug-bash@gnu.org
In-Reply-To: <m3k8648i94.fsf@appel.lilypond.org> <Pine.LNX.3.95.1010305083112.8719A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010305083112.8719A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Mar 05, 2001 at 08:40:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:

> Somebody must have missed the boat entirely. Unix does not, never
> has, and never will end a text line with '\r'.

Unix does not, never has, and never will end a text line with ' ' (a
space character) or with \t (a tab character).  Yet if I begin a shell
script with '#!/bin/sh ' or '#!/bin/sh\t', the training white space is
striped and /bin/sh gets exec'd.  Since \r has no special significance
to Unix, I'd expect it to be treated the same as any other whitespace
character -- it should be striped, and /bin/sh should get exec'd.

-- 
John Kodis <kodis@acm.org>
Phone: 301-286-7376
