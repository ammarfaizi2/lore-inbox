Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135181AbRDZIHa>; Thu, 26 Apr 2001 04:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135185AbRDZIHM>; Thu, 26 Apr 2001 04:07:12 -0400
Received: from zmailer.org ([194.252.70.162]:50190 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S135181AbRDZIGu>;
	Thu, 26 Apr 2001 04:06:50 -0400
Date: Thu, 26 Apr 2001 11:06:36 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: ADMIN: Reminder to VERIFY your email routing functionality!
Message-ID: <20010426110636.M805@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting *somewhat* annoyed with subscribers whose domains
have backup servers not willing to receive email for them.

On average each day we get dozens to hundreds of bounces of this
routing-trouble type pointing to 2-3 domains each time.

Do use the MX verifier server at page:
   http://vger.kernel.org/mxverify.html
by entering your down address into the entry box (for VGER), and
then click on associated SUBMIT button.

Get into habit of using that tool weekly, things often *do* change
in cases where you rely on other people giving you some service.


That tool does email domain routing by the generic Internet Rules
(See RFC 2821 for concise presentation), and then tests SMTP level
protocol transactions for actual delivery.  YOU, the subscriber,
do not need to understand the algorthms behind it, it does tell if
all goes ok, or if something fails.  In case of failures, do contact
your ISP email wranglers; usually  <postmaster@isp-domain>, possibly
also <helpdesk@isp-domain>.  (And if they reject MAIL FROM:<>, do
ask them why the violate RFC 821/2821 ?)


I am also contemplating a change into policy -- we (me and DaveM)
have been somewhat lenient if people cause less than whole day of
bounces by "we do not relay to that domain" (or some other text of
same meaning) messages.   NEW POLICY  might soon be:  EVEN ONE SUCH
BOUNCE, AND YOUR SUBSCRIPTION IS HISTORY.  (Until you resubscribe,
that is.  We don't blacklist, just remove.)

Analyzing reasons and tracking bounces is bloody timeconsuming.


Statistics being a continuum of event kinds, during past 7 days there
has been one day when we got unusually low number of MX bounces, and
it wasn't any way quiet day at linux-kernel list...

There are presently 3165 subscribers with 2608 different domains, thus
I can guess that many feel that this does not concern them - especially
if you subscribe/use some large email service provider to give you
the service.   Don't consider that to be any sort of safety - we have
seen people like HOME.COM  to blow it in the past...

If you have your own domain served at some ISP bulk server, they PROBABLY
have blown it.

/Matti Aarnio -- co-postmaster at vger.kernel.org
              -- watching the world by received error reports, never seeing
                 success reports...
