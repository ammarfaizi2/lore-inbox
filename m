Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSESEFy>; Sun, 19 May 2002 00:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314126AbSESEFx>; Sun, 19 May 2002 00:05:53 -0400
Received: from imo-m01.mx.aol.com ([64.12.136.4]:25076 "EHLO
	imo-m01.mx.aol.com") by vger.kernel.org with ESMTP
	id <S314096AbSESEFx>; Sun, 19 May 2002 00:05:53 -0400
Date: Sun, 19 May 2002 00:05:52 -0400
From: oriveros@netscape.net (Oscar Riveros)
To: linux-kernel@vger.kernel.org
Subject: kernel: Assertion failure in journal_revoke() at revoke.c:330 in kernel 2.4.18
Message-ID: <2446DD7E.7F1AEC90.00A5E169@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing with cyrus-imapd and suddently got:

# /etc/init.d/cyrus21 stop
Stopping Cyrus IMAPd master server: cyrmaster.
# /etc/init.d/cyrus21 start
Starting Cyrus IMAPd master server: cyrmaster.
# 
Message from syslogd@cr2167222090 at Sat May 18 22:23:52 2002 ...
cr2167222090 kernel: Assertion failure in journal_revoke() at revoke.c:330: "!(__builtin_constant_p(BH_Revoked) ? constant_test_bit((BH_Revoked),( &bh->b_state)) : variable_test_bit((BH_Revoked),( &bh->b_state)))"

Message from syslogd@cr2167222090 at Sat May 18 22:23:52 2002 ...
cr2167222090 kernel: Assertion failure in journal_revoke() at revoke.c:330: "!(__builtin_constant_p(BH_Revoked) ? constant_test_bit((BH_Revoked),( &bh->b_state)) : variable_test_bit((BH_Revoked),( &bh->b_state)))"

And now my system is not responding (except pings),  I have no more info at the time... becouse the computer is at the office.

BTW It is a 1.33 MH Atlon with 256MB DDR and a 40GB HD.  The kernel is a costume configured 2.4.18.

Please C.C. me, I'm not in the list =)

Thanks.

Oscar Riveros



__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

