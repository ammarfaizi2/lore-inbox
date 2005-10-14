Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVJNFef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVJNFef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVJNFef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 01:34:35 -0400
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:25749 "HELO
	web31506.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751159AbVJNFef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 01:34:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=49BLIdmN0VdSsYYjuagHzLL1XrK4T+czCy8l2XPnH07E9/4sncHtjnOSHvDiR7HjXxXqE9TfmxHl6SYATig4M//aq17pkrTcFPcvfwjf5XsoLz8SnIb4z1X8/40Hgf5dUPgiAZSeNc7gAoygkwmfYyZuBg7QXorriaLxFc3f9pA=  ;
Message-ID: <20051014053434.96559.qmail@web31506.mail.mud.yahoo.com>
Date: Thu, 13 Oct 2005 22:34:34 -0700 (PDT)
From: Jonathan Day <imipak@yahoo.com>
Subject: Linux network configuration option query
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This may sound like a really dumb question, but would
anyone have any objection if I cleaned up the menu
options for the networking?

The options don't seem to be grouped by function and
some of the 802.11 options are outside of the general
options list altogether, although I would argue they
are NOT higher level than options in lower-level menus
from that point.

There are also far too many options in the main
networking options menu, some indented and some on
other pages, with no obvious pattern or organization.

(eg: IPSec options seem to be sprinkled through like
seasoning. The classifier options at the end seem very
related to the advanced routing and the netfilter
code, yet are dependent on the classifier API in the
QoS menu which doesn't obviously relate to Quality of
Service. The TCP optimizations -do- seem to offer
"Quality of Service", but are in their own menu set.
And so on.)

The biggest problem I can see with my proposal is that
it's likely to get up the collective noses of every
single Linux network coder, particularly if I start
shuffling classifier-related code around. The second
drawback is that it would make for a lot of changes
that would have no actual code value whatsoever and
would mostly benefit those who both rolled their own
kernels AND had untreated OCD.

I'm not fond of being fed to giant rats, so I'd rather
know what the prevaling view was on the network code
layout.



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
