Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTLBRGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTLBRGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:06:46 -0500
Received: from cruftix.physics.uiowa.edu ([128.255.70.79]:57998 "EHLO cruftix")
	by vger.kernel.org with ESMTP id S262598AbTLBRGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:06:45 -0500
Date: Tue, 2 Dec 2003 11:06:39 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz
Subject: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031202170637.GD5475@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org, perex@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

I'm having problems getting the CS4236+ driver to recognize my 
  CS4236B card.  pnp finds it on boot:
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: 1 Plug & Play card detected total

but the ALSA driver doesn't pick it up.
isapnp detection failed and probing for CS4236+ is not supported
CS4236+ soundcard not found or device busy

Furthermore, after fudging with manually setting it up via modprobe
  options, it's still not loading:
CS4236+ soundcard not found or device busy

This used to work in the 2.4 series kernel without any modprobe.conf
  settings; the OSS driver would pick it up.

Any assistance would be greatly appreciated; this is the only thing holding
  me back from 2.6 goodness.  ;)

[config, pnpdump, and other information available on request]
-Joseph
-- 
trelane@digitasaru.net--------------------------------------------------
"We continue to live in a world where all our know-how is locked into
 binary files in an unknown format. If our documents are our corporate
 memory, Microsoft still has us all condemned to Alzheimer's."
    --Simon Phipps, http://theregister.com/content/4/30410.html
