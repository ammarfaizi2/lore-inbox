Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbRFAVc4>; Fri, 1 Jun 2001 17:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbRFAVcq>; Fri, 1 Jun 2001 17:32:46 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:41785 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S261577AbRFAVcg>; Fri, 1 Jun 2001 17:32:36 -0400
Subject: Re: USB mouse wheel breakage was Re: Linux 2.4.5-ac5
From: Robert "M." Love <rml@tech9.net>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <991399435.4435.0.camel@phantasy>
In-Reply-To: <20010601105717.A2468@debian>  <991399435.4435.0.camel@phantasy>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 01 Jun 2001 17:32:26 -0400
Message-Id: <991431152.653.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB mouse wheel has been broke since 2.4.5-ac4 (when new USB HID,
hid-core.c, was integrated).  The mouse in general seems jerky, and
specifically the input device does not receive events for consecutive
wheel movements -- just the first "spin," until the mouse is moved
again.

obviously the bug is in the new hid-core.c, but I confirmed this by
compiling with that part of the ac6 patch removed.  I have since been
trying to write a patch but I can not fix the problem, so I am reporting
it to you.

I and another user thought the problem was in hid_input_field, but upon
looking I now think not.

My mouse is fairly unusable in X, and unfortunately I can not figure out
a fix.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

