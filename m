Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137135AbREKNeT>; Fri, 11 May 2001 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137136AbREKNeK>; Fri, 11 May 2001 09:34:10 -0400
Received: from zmailer.org ([194.252.70.162]:41478 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S137135AbREKNeE>;
	Fri, 11 May 2001 09:34:04 -0400
Date: Fri, 11 May 2001 16:33:45 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: ADMIN: Email client feed and care ...
Message-ID: <20010511163345.H5947@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

  I really don't know what I should do when legitimate (but malformed)
email gets bounced by some systems because their writers consider that
malformed email is a bad thing, and must not be accepted.

  We see also increasing amount of bounces by systems who think that
some 10 line linux-kernel text message is spam...

  There are two things:
      - Senders must REALLY send valid messages
      - Recipients SHOULD be more lenient on what they accept
        (And spam-detectors be smarter.  Having URLs mentioned
         in message text - maybe that was the reason - should
         not mean it is spam...)

If we ever automate recipient removal (we have means for it, more or
less), there would be no warning whatsoever when a subscriber gets
kicked out.

          /Matti Aarnio

FAILED:
  Original Recipient:
    rfc822;ml-linux_kernel@ignus.com
  Control data:
    smtp ignus.com ml-linux_kernel@ignus.com 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=1718
    ->> 250 Ok.
    <<- RCPT To:<ml-linux_kernel@ignus.com> NOTIFY=FAILURE ORCPT=rfc822;ml-linux_kernel@ignus.com
    ->> 250 Ok.
    <<- DATA
    ->> 354 Ok.
    <<- .
    ->> 550-This message has 8-bit content, but does not have the required MIME
    ->> 550-headers.  Sorry, this mail server does not accept mail without the
    ->> 550-required MIME headers.  See <URL:ftp://ftp.isi.edu/in-notes/rfc2045.txt>
    ->> 550 for more information.
FAILED:
  Original Recipient:
    rfc822;user5@test.wirex.com
  Control data:
    smtp test.wirex.com user5@test.wirex.com 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=1718
    ->> 250 Ok.
    <<- RCPT To:<user5@test.wirex.com> NOTIFY=FAILURE ORCPT=rfc822;user5@test.wirex.com
    ->> 250 Ok.
    <<- DATA
    ->> 354 Ok.
    <<- .
    ->> 550-This message has 8-bit contents, but does not have the necessary MIME
    ->> 550-headers.  Sorry, this mail server does not accept mail without the
    ->> 550-required MIME headers.  See <URL:ftp://ftp.isi.edu/in-notes/rfc2045.txt>
    ->> 550 for more information.


Content-Type: message/rfc822

Subject: Re: monitor file writes
From:	Xavier Bestel <xavier.bestel@free.fr>
To:	Dennis Bjorklund <db@zigo.dhs.org>
Cc:	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105080624120.14983-100000@merlin.zigo.dhs.org>
In-Reply-To: <Pine.LNX.4.30.0105080624120.14983-100000@merlin.zigo.dhs.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date:	11 May 2001 13:51:26 +0200
Message-Id: <989581889.19092.1.camel@nomade>
Mime-Version: 1.0
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

Le 08 May 2001 06:27:52 +0200, Dennis Bjorklund a écrit :
> Is there a way in linux to montior file writes?
> 
> I have something that is writing to the disk every 5:th second (approx.)

probably kupdate ... look for noflushd on freshmeat.net and read the
docs.

Xav

