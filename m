Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbQLARpf>; Fri, 1 Dec 2000 12:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQLARpZ>; Fri, 1 Dec 2000 12:45:25 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:23509 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S129524AbQLARpO>;
	Fri, 1 Dec 2000 12:45:14 -0500
Date: Fri, 1 Dec 2000 12:14:38 -0500
From: Olivier Galibert <galibert@pobox.com>
To: "T. Camp" <campt@openmars.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
Message-ID: <20001201121438.B13401@zalem.puupuu.org>
Mail-Followup-To: "T. Camp" <campt@openmars.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012011655300.1488-100000@penguin.homenet> <Pine.LNX.4.21.0012010904260.4856-100000@magic.skylab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0012010904260.4856-100000@magic.skylab.org>; from campt@openmars.com on Fri, Dec 01, 2000 at 09:05:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 09:05:23AM -0800, T. Camp wrote:
> Hmm didn't know that, from the user-land portable C perspective I'm in the
> habit of zero'ing everything. - thanks.

It's a requirement of the ISO C standard that all global/static (not
local) variables are initialized to 0 is not initialized explicitely.
It tends to be true, too.

  OG.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
