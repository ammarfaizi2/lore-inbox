Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDHWMW>; Sun, 8 Apr 2001 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRDHWMN>; Sun, 8 Apr 2001 18:12:13 -0400
Received: from james.kalifornia.com ([208.179.59.2]:65397 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131233AbRDHWL4>; Sun, 8 Apr 2001 18:11:56 -0400
Message-ID: <3AD0E229.6010807@blue-labs.org>
Date: Sun, 08 Apr 2001 15:11:53 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre8 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: To: davidel@xmailserver.org [Fwd: Returned mail: see transcript for details]
Content-Type: multipart/mixed;
 boundary="------------060501060608070100010102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060501060608070100010102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Your email address seems to be broken ;)

I tried from different networks.

rcpt to:<davidel@xmailserver.org>
550 Relay denied

-d


--------------060501060608070100010102
Content-Type: message/rfc822;
 name="Returned mail: see transcript for details"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Returned mail: see transcript for details"

Return-Path: <MAILER-DAEMON@james.kalifornia.com>
Received: from localhost (david@localhost [127.0.0.1])
	by Huntington-Beach.Blue-Labs.org (8.11.3/8.11.0) with ESMTP id f38M0Av30107
	for <david@localhost>; Sun, 8 Apr 2001 15:00:10 -0700
Received: from mail.kalifornia.com [208.179.59.2]
	by localhost with IMAP (fetchmail-5.6.2)
	for david@localhost (single-drop); Sun, 08 Apr 2001 15:00:10 -0700 (PDT)
Received: from localhost (localhost)
	by james.kalifornia.com (8.12.0.Beta5/8.12.0.Beta5) id f38M01UL028320;
	Sun, 8 Apr 2001 15:00:03 -0700
Date: Sun, 8 Apr 2001 15:00:03 -0700
From: Mail Delivery Subsystem <MAILER-DAEMON@james.kalifornia.com>
Message-Id: <200104082200.f38M01UL028320@james.kalifornia.com>
To: <david@blue-labs.org>
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="f38M01UL028320.986767203/james.kalifornia.com"
Subject: Returned mail: see transcript for details
Auto-Submitted: auto-generated (failure)

This is a MIME-encapsulated message

--f38M01UL028320.986767203/james.kalifornia.com

The original message was received at Sun, 8 Apr 2001 14:48:51 -0700
from david@Huntington-Beach.Blue-Labs.org [208.179.59.198]

   ----- The following addresses had permanent fatal errors -----
<davidel@xmailserver.org>
    (reason: 550 Relay denied)

   ----- Transcript of session follows -----
... while talking to host1.xmailserver.org.:
>>> DATA
<<< 550 Relay denied
550 5.1.1 <davidel@xmailserver.org>... User unknown
<<< 503 Bad sequence of commands

--f38M01UL028320.986767203/james.kalifornia.com
Content-Type: message/delivery-status

Reporting-MTA: dns; james.kalifornia.com
Arrival-Date: Sun, 8 Apr 2001 14:48:51 -0700

Final-Recipient: RFC822; davidel@xmailserver.org
Action: failed
Status: 5.1.1
Remote-MTA: DNS; host1.xmailserver.org
Diagnostic-Code: SMTP; 550 Relay denied
Last-Attempt-Date: Sun, 8 Apr 2001 15:00:03 -0700

--f38M01UL028320.986767203/james.kalifornia.com
Content-Type: message/rfc822

Return-Path: <david@blue-labs.org>
Received: from blue-labs.org (david@Huntington-Beach.Blue-Labs.org [208.179.59.198])
	(authenticated (0 bits))
	by james.kalifornia.com (8.12.0.Beta5/8.12.0.Beta5) with ESMTP id f38Lmol6027750
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NO)
	for <davidel@xmailserver.org>; Sun, 8 Apr 2001 14:48:51 -0700
Message-ID: <3AD0DCC2.1020901@blue-labs.org>
Date: Sun, 08 Apr 2001 14:48:50 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre8 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: goodbye
In-Reply-To: <XFMail.20010408110052.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Most MTAs already have capabilities developed to grant or revoke relay 
access based upon IP or host mask.

-d

Davide Libenzi wrote:

> I had the same problem of shifting down along the mail chain the knowledge of
> the incoming IP address.
> We develop VirusScreening and ContentFiltering MTA ( and appliances ) that
> usually goes in front of customers MTA.
> By putting our MTA in front of the customer MTAs chain We hide the peer IP
> address to MTAs that comes next in the mail chain.
> Our MTA uses a new ESMTP command :
> 
> XRMTIP remote-ip-address
> 
> to let customers MTA to know the remote IP address and let them to take all
> relay and generic permissions decisions about the mail path.
> We're going to distribute patches for most common MTAs like qmail, sendmail,
> exim, XMail and postfix.
> The patch rely on the presence of a file ( /etc/xrmtip.hosts ) that list the IPs
> from which the XRMTIP command sould be accepted.




--f38M01UL028320.986767203/james.kalifornia.com--

--------------060501060608070100010102--

