Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285310AbRLSOyC>; Wed, 19 Dec 2001 09:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285309AbRLSOxp>; Wed, 19 Dec 2001 09:53:45 -0500
Received: from mail.zmailer.org ([194.252.70.162]:53891 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S285308AbRLSOxh>;
	Wed, 19 Dec 2001 09:53:37 -0500
Date: Wed, 19 Dec 2001 16:53:26 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: bgodette@idcomm.com
Cc: linux-kernel@vger.kernel.org
Subject: Careless MTA admins and poison in RBL/ORBS/ORBZ zones...
Message-ID: <20011219165326.C1870@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


  I see people using defunct RBL/ORBS/ORBZ zones, which contain poison:

;; ANSWER SECTION:
194.24.183.199.orbz.gst-group.co.uk.  25w5d IN TXT  "This zone is defunct stop using it."

  As a result, those using them are bound to have all their incoming email
(or a sizable portion, there is) becoming rejected irregardless if there
is any real _RBL_ on address, or not.

Carefull out there folks,  keep an eye at your configurations, especially
if you are trying to use "free" RBL-like databases.  They appear to have
limited lifespans.

/Matti Aarnio -- co-postmaster of vger.kernel.org

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Received: from vger.kernel.org ([IPv6:::ffff:199.183.24.194]:2736 "EHLO
	vger.kernel.org" smtp-auth: <none> TLS-CIPHER: <none> TLS-PEER: <none>)
	by mail.zmailer.org with ESMTP id <S257047AbRLSOnw>;
	Wed, 19 Dec 2001 16:43:52 +0200
Received: (@vger.kernel.org) by vger.kernel.org id <S285303AbRLSOnm>;
	Wed, 19 Dec 2001 09:43:42 -0500
To:	linux-kernel-owner@vger.kernel.org
From:	The Post Office <postmaster@vger.kernel.org>
Sender:	mailer-daemon@vger.kernel.org
Subject: Delivery reports about your email [FAILED(1)]
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="S285303AbRLSOnm=_/vger.kernel.org"
Message-Id: <20011219144347Z285303-18284+4304@vger.kernel.org>
Date:	Wed, 19 Dec 2001 09:43:42 -0500
Return-Path: <>
X-Envelope-To: <mea+vger.redhat.com@zmailer.org> (uid 99)
X-Orcpt: rfc822;postoffice

This is MULTIPART/REPORT structured message as defined at RFC 1894.

Ask your email client software vendor, when will they support this
report format by showing its formal part in your preferred language.

--S285303AbRLSOnm=_/vger.kernel.org
Content-Type: text/plain

This is a collection of reports about email delivery
process concerning a message you originated.

Some explanations/translations for these reports
can be found at:
      http://www.zmailer.org/reports.html

Generic VGER note:  Joining/leaving VGER's lists thru server:
			majordomo@vger.kernel.org

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Wed, 19 Dec 2001 09:27:09 -0500
Local-Spool-ID: S285291AbRLSO1J


FAILED:
  Original Recipient:
      rfc822;bgodette@idcomm.com
  Final Recipient:
      RFC822;bgodette@idcomm.com
  Status:
      5.7.1
  Remote MTA:
      dns; brainstem.idcomm.com (207.40.196.12|25|199.183.24.194|42560)
  Last Attempt Date:
      Wed, 19 Dec 2001 09:28:54 -0500
  X-ZTAID:
      smtp[5073]
  Diagnostic Code:
      smtp; 550 (<bgodette@idcomm.com>... Mail from 199.183.24.194 refused by blackhole site orbz.gst-group.co.uk)
  Control data:
      smtp idcomm.com bgodette@idcomm.com 99
  Diagnostic texts:
      <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=3040
     ->> 250 2.1.0 <linux-kernel-owner@vger.kernel.org>... Sender ok
     <<- RCPT To:<bgodette@idcomm.com> NOTIFY=FAILURE ORCPT=rfc822;bgodette@idcomm.com
     ->> 550 5.7.1 <bgodette@idcomm.com>... Mail from 199.183.24.194 refused by blackhole site orbz.gst-group.co.uk

Following is a copy of MESSAGE/DELIVERY-STATUS format section below.
It is copied here in case your email client is unable to show it to you.
The information here below is in  Internet Standard  format designed to
assist automatic, and accurate presentation and usage of said information.
In case you need human assistance from the Postmaster(s) of the system which
sent you this report, please include this information in your question!

    Virtually Yours,
        Automatic Email Delivery Software

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Wed, 19 Dec 2001 09:27:09 -0500
Local-Spool-ID: S285291AbRLSO1J

Original-Recipient: rfc822;bgodette@idcomm.com
Final-Recipient: RFC822;bgodette@idcomm.com
Action: failed
Status: 5.7.1
Remote-MTA: dns; brainstem.idcomm.com (207.40.196.12|25|199.183.24.194|42560)
Last-Attempt-Date: Wed, 19 Dec 2001 09:28:54 -0500
Diagnostic-Code: smtp; 550 (<bgodette@idcomm.com>... Mail from 199.183.24.194 refused by blackhole site orbz.gst-group.co.uk)


Following is copy of the message headers. Original message content may
be in subsequent parts of this MESSAGE/DELIVERY-STATUS structure.

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285291AbRLSO1J>; Wed, 19 Dec 2001 09:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285303AbRLSO07>; Wed, 19 Dec 2001 09:26:59 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:51719 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285291AbRLSO0u>; Wed, 19 Dec 2001 09:26:50 -0500
Received: (qmail 25727 invoked from network); 19 Dec 2001 14:26:45 -0000
Received: from unknown (HELO angband.namesys.com) (postfix@212.16.7.123)
  by thebsh.namesys.com with SMTP; 19 Dec 2001 14:26:45 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 501)
	id B4F952251D7; Wed, 19 Dec 2001 17:26:44 +0300 (MSK)
Date:	Wed, 19 Dec 2001 17:26:44 +0300
From:	Oleg Drokin <green@namesys.com>
To:	Masaru Kawashima <masaruk@gol.com>
Cc:	lkml <linux-kernel@vger.kernel.org>,
	reiserfs-list <reiserfs-list@namesys.com>, chris@suse.de
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-ID: <20011219172644.A28692@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva> <20011219230812.049c2c5c.masaruk@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011219230812.049c2c5c.masaruk@gol.com>
User-Agent: Mutt/1.3.22.1i
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org


--S285303AbRLSOnm=_/vger.kernel.org
Content-Type: message/delivery-status

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Wed, 19 Dec 2001 09:27:09 -0500
Local-Spool-ID: S285291AbRLSO1J

Original-Recipient: rfc822;bgodette@idcomm.com
Final-Recipient: RFC822;bgodette@idcomm.com
Action: failed
Status: 5.7.1
Remote-MTA: dns; brainstem.idcomm.com (207.40.196.12|25|199.183.24.194|42560)
Last-Attempt-Date: Wed, 19 Dec 2001 09:28:54 -0500
Diagnostic-Code: smtp; 550 (<bgodette@idcomm.com>... Mail from 199.183.24.194 refused by blackhole site orbz.gst-group.co.uk)

--S285303AbRLSOnm=_/vger.kernel.org
Content-Type: message/rfc822

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285291AbRLSO1J>; Wed, 19 Dec 2001 09:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285303AbRLSO07>; Wed, 19 Dec 2001 09:26:59 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:51719 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285291AbRLSO0u>; Wed, 19 Dec 2001 09:26:50 -0500
Received: (qmail 25727 invoked from network); 19 Dec 2001 14:26:45 -0000
Received: from unknown (HELO angband.namesys.com) (postfix@212.16.7.123)
  by thebsh.namesys.com with SMTP; 19 Dec 2001 14:26:45 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 501)
	id B4F952251D7; Wed, 19 Dec 2001 17:26:44 +0300 (MSK)
Date:	Wed, 19 Dec 2001 17:26:44 +0300
From:	Oleg Drokin <green@namesys.com>
To:	Masaru Kawashima <masaruk@gol.com>
Cc:	lkml <linux-kernel@vger.kernel.org>,
	reiserfs-list <reiserfs-list@namesys.com>, chris@suse.de
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-ID: <20011219172644.A28692@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva> <20011219230812.049c2c5c.masaruk@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011219230812.049c2c5c.masaruk@gol.com>
User-Agent: Mutt/1.3.22.1i
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

Hello!

On Wed, Dec 19, 2001 at 11:08:12PM +0900, Masaru Kawashima wrote:

> > - Reiserfs fixes				(Oleg Drokin/Chris Mason)

> There is still reiserfs remount problem with 2.4.17-rc2.
Hmmm.
Few things needs to be verified:
Is your reiserfs root partition 3.5 or 3.6 format? (can be checked in /proc/fs/reiserfs/.../version
Try to boot of different media (rescue disk/CD) and run resiserfsck on your root partition,
is there any errors? If yes - then fix them (with reiserfsck --rebuild-tree probably),
and try to boot off your root disk again.
Remember to read FAQ entry on reiserfsck --rebuild-tree on namesys.com web site.

> >>EIP; c0159f54 <_get_block_create_0+748/85c>   <=====
> 00000000 <_EIP>:
> Code;  c0159f54 <_get_block_create_0+748/85c>   <=====
>    0:   0f 0b                     ud2a      <=====
Ok, so it is this code in _get_block_create_0:
        if (!is_direct_le_ih (ih)) {
            BUG ();
        }
Hm.
Is your root partition big?
I want to look at it is that's possible.
At least at the metadata (reiserfsutils contains tools to extract metadata from disk drive,
if you'd extract such metadata and send it to me before you run reiserfsck - that would be great)

Thank you.

Bye,
    Oleg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--S285303AbRLSOnm=_/vger.kernel.org--

--d6Gm4EdcadzBjdND--
