Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbRGNIwW>; Sat, 14 Jul 2001 04:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbRGNIwM>; Sat, 14 Jul 2001 04:52:12 -0400
Received: from mail.zmailer.org ([194.252.70.162]:41479 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S267598AbRGNIvx>;
	Sat, 14 Jul 2001 04:51:53 -0400
Date: Sat, 14 Jul 2001 11:55:06 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org
Subject: ORBS blacklist is BROKEN (deliberately)...
Message-ID: <20010714115506.G18653@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a good representative sample of things I am seeing right now.

The crux is that those who broke it are running a very black version
indeed.  Doing command:

  dig @63.92.26.236 any *.relays.orbs.org.

will show you A and TXT data FOR WILDCARD ('star') ENTRY!
AND ONLY FROM THAT ONE SERVER OUT OF THEM ALL!

I also went around and checked all other alike services.
The grand-father of them:  RBL  (www.mail-abuse.org)  is now
A SUBSCRIPTION ONLY service, thus it also is out of the picture...
(Except for those who want to subscribe it.)




FAILED:
  Original Recipient:
    rfc822;camm@enhanced.com
  Control data:
    smtp enhanced.com camm@enhanced.com 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> SIZE=2586
    ->> 250 <linux-kernel-owner@vger.kernel.org> is syntactically correct
    <<- RCPT To:<camm@enhanced.com>
    ->> 550-MAIL BLOCKED; See http://www.e-scrub.com/orbs/
    ->> 550 rejected: administrative prohibition
FAILED:
  Original Recipient:
    rfc822;linux-kernel@cs.helsinki.fi
  Control data:
    smtp cs.helsinki.fi linux-kernel@cs.helsinki.fi 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=2586
    ->> 250 2.1.0 <linux-kernel-owner@vger.kernel.org>... Sender ok
    <<- RCPT To:<linux-kernel@cs.helsinki.fi> NOTIFY=FAILURE ORCPT=rfc822;linux-kernel@cs.helsinki.fi
    ->> 550 5.7.1 <linux-kernel@cs.helsinki.fi>... Mail from vger.kernel.org blocked by DNS blacklist inputs.orbs.org, see http://www.cs.Helsinki.FI/block.html
FAILED:
  Original Recipient:
    rfc822;samkaski@cs.helsinki.fi
  Control data:
    smtp cs.helsinki.fi samkaski@cs.helsinki.fi 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=2586
    ->> 250 2.1.0 <linux-kernel-owner@vger.kernel.org>... Sender ok
    <<- RCPT To:<samkaski@cs.helsinki.fi> NOTIFY=FAILURE ORCPT=rfc822;samkaski@cs.helsinki.fi
    ->> 550 5.7.1 <samkaski@cs.helsinki.fi>... Mail from vger.kernel.org blocked by DNS blacklist inputs.orbs.org, see http://www.cs.Helsinki.FI/block.html
FAILED:
  Original Recipient:
    rfc822;hjubing@china.com
  Control data:
    smtp china.com hjubing@china.com 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME
    ->> 250 <linux-kernel-owner@vger.kernel.org>, sender ok.
    <<- RCPT To:<hjubing@china.com>
    ->> 250 <hjubing>, Local recipient ok.
    <<- DATA
    ->> 354 Start mail input; end with <CRLF>.<CRLF>
    <<- .
    ->> 553 Too many Received key words in the mail, should less than 5
FAILED:
  Original Recipient:
    rfc822;giampietro@mailbox.dsnet.it
  Control data:
    smtp mailbox.dsnet.it giampietro@mailbox.dsnet.it 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=2586
    ->> 553 sorry, your mailserver is listed in an RBL, mail from your location is not accepted here (#5.7.1)
    <<- RCPT To:<giampietro@mailbox.dsnet.it>
    ->> 503 MAIL first (#5.5.1)

