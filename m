Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRLDAqu>; Mon, 3 Dec 2001 19:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282151AbRLDAqM>; Mon, 3 Dec 2001 19:46:12 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:2988 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S282131AbRLDApc>;
	Mon, 3 Dec 2001 19:45:32 -0500
Message-ID: <00eb01c17c5c$deda04b0$0801a8c0@Stev.org>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200010131722.e9DHMwL17616@pincoya.inf.utfsm.cl> <39EC6F4E.8FC87501@nortelnetworks.com> <3C0BA20F.946E0F1B@nortelnetworks.com>
Subject: Re: possible to do non-blocking write to NFS?
Date: Tue, 4 Dec 2001 00:44:45 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there any way to write to an NFS-mounted filesystem in a way that will
avoid
> all of the NFS retries?  Basically I want to try a write, and if the
server is
> not accessable I want to return immediately with an error code.

see the mount options for nfs
under the mount and nfs man pages

> Would setting the O_NONBLOCK flag on opening the file give me this
behaviour?
>

no it would not

    James


