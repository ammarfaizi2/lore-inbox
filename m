Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbQLKO41>; Mon, 11 Dec 2000 09:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbQLKO4S>; Mon, 11 Dec 2000 09:56:18 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:32485 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129725AbQLKO4L>; Mon, 11 Dec 2000 09:56:11 -0500
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: No shared memory??
In-Reply-To: <Pine.LNX.4.30.0012100306530.4353-100000@playtoy.hislinuxbox.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.30.0012100306530.4353-100000@playtoy.hislinuxbox.com>
Message-ID: <m3puiz11t3.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 11 Dec 2000 15:28:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David D.W. Downey" <pgpkeys@hislinuxbox.com> writes:

> When running top, procinfo, or free I get 0 for Shared memory. Obviously
> this is incorrect. What has changed from the 2.2.x and the 2.4.x that
> would cause these apps to misreport this information.

Known 2.4 behaviour. It is simply to costly to calculate that. It will
always show as 0.

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
