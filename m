Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRARIYQ>; Thu, 18 Jan 2001 03:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbRARIYI>; Thu, 18 Jan 2001 03:24:08 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:57329 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130069AbRARIX5>; Thu, 18 Jan 2001 03:23:57 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@innominate.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.31.0101171932460.31432-100000@localhost.localdomain>
Organisation: SAP LinuxLab
Date: 18 Jan 2001 09:23:41 +0100
In-Reply-To: <Pine.LNX.4.31.0101171932460.31432-100000@localhost.localdomain>
Message-ID: <qwwk87tclpu.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Wed, 17 Jan 2001, Rik van Riel wrote:
> I don't even want to start thinking about how this would
> screw up the (already fragile) page aging balance...

As of 2.4.1-pre we pin the pages by increasing the page count for
locked segments. No special list needed.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
