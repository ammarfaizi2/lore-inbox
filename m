Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264496AbRFOTip>; Fri, 15 Jun 2001 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264497AbRFOTif>; Fri, 15 Jun 2001 15:38:35 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:29961 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264496AbRFOTiX>;
	Fri, 15 Jun 2001 15:38:23 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106151938.f5FJcIJ288693@saturn.cs.uml.edu>
Subject: Re: [patch] nonblinking VGA block cursor
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Fri, 15 Jun 2001 15:38:18 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), ljb@devco.net (Leon Breedt),
        linux-kernel@vger.kernel.org
In-Reply-To: <0106152134050C.00879@starship> from "Daniel Phillips" at Jun 15, 2001 09:34:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On Friday 15 June 2001 21:21, Albert D. Cahalan wrote:

>> Non-blinking cursors are just wrong. You need to patch your brain.
>> You really fucked up, because now apps can't restore your cursor
>> to proper behavior as defined by IBM.
>
> Just one question Albert: why doesn't my mouse cursor blink? ;-)

1. confusion with the text cursor, which should blink
2. need for continuous pixel-to-pixel accuracy with the mouse
3. you can wiggle your mouse as needed to find the mouse cursor

Apps do funny things when you try to wiggle the text cursor
with the arrow keys, and movement tends to be harshly constrained.
So the blinking is important.
