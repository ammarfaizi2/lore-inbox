Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129686AbQJQAMF>; Mon, 16 Oct 2000 20:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129558AbQJQALp>; Mon, 16 Oct 2000 20:11:45 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:14084 "EHLO vger.timpanogas.org") by vger.kernel.org with ESMTP id <S129097AbQJQALf>; Mon, 16 Oct 2000 20:11:35 -0400
Received: from timpanogas.org ([207.109.151.230]) by vger.timpanogas.org (8.9.3/8.9.3) with ESMTP id RAA01123 for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2000 17:56:53 -0600
Message-ID: <39EB95B8.25078A0A@timpanogas.org>
Date: Mon, 16 Oct 2000 17:56:40 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MANOS/Ute-Linux mailing List problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For you guys on the manos-kernel/ute-linux mailing lists, the reason the
list has not been sending out emails for the past week is due some
employees internal at Novell playing games with our servers.  What
appears to be going on is they have registered several bogus email
addresses with bogus domains that point to MX records that route through
these bogus domains back into MX -> prv-mx.provo.novell.com. 

They apparantley setup the DNS entries incorrectly, which is causing the
buggy NetWare/Groupwise DNS servers at Novell to hang when a connection
is opened to port 25 on their primary mail exchanger, and an email loop
to form back to majordomo, which has resulted in majordomo freezing up
during bulk resend (because majordomo fills up the entire disk with the
same messages.  The /var/spool/mqueue diretory appears to still have all
the emails posted and as soon as we disable routing to Novell's DNS mail
exchangers, the messages will repost.  

We apologize for the list problems, and will have it back up later this
evening. 

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
