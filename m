Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbRLPX4k>; Sun, 16 Dec 2001 18:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284934AbRLPX4a>; Sun, 16 Dec 2001 18:56:30 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:10639 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S284933AbRLPX4X>;
	Sun, 16 Dec 2001 18:56:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Adam Schrotenboer <adam@tabris.net>
Subject: Re: Is /dev/shm needed?
Date: Sun, 16 Dec 2001 15:56:17 -0800
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16Fkqc-0001Z0-00@DervishD.viadomus.com> <20011216234748.3EDE9FB80D@tabris.net>
In-Reply-To: <20011216234748.3EDE9FB80D@tabris.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Fl8j-0000nA-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 16, 2001 15:47, Adam Schrotenboer wrote:
> I may be wrong about /tmp as well, but I have come to think that it is data
> that ought be discarded after logout, and have sometimes considered writing
> a script for it in the login/logout scripts.

System daemons can legally use /tmp, and they may not apprechiate having 
their files removed from underneath them everytime someone telnets in. ;)

-Ryan
