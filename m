Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbREMSVB>; Sun, 13 May 2001 14:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263262AbREMSUv>; Sun, 13 May 2001 14:20:51 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:48299 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S263062AbREMSUj>; Sun, 13 May 2001 14:20:39 -0400
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vincent Stemen <linuxkernel@AdvancedResearch.org>,
        Jacky Liu <jq419@my-deja.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 kernel freeze for unknown reason
In-Reply-To: <Pine.LNX.4.33.0105120709570.479-100000@mikeg.weiden.de>
Organisation: SAP LinuxLab
In-Reply-To: <Pine.LNX.4.33.0105120709570.479-100000@mikeg.weiden.de>
Message-ID: <m3ae4id4tc.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
Date: 13 May 2001 20:16:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sat, 12 May 2001, Mike Galbraith wrote:
> Why do I not see this behavior with a heavy swap throughput test
> load?  It seems decidedly odd to me that swapspace should remain
> allocated on other folks lightly loaded boxen given that my heavily
> loaded box does release swapspace quite regularly.  What am I
> missing?

Are you using a database or something other which mostly uses shared
mem/tmpfs? This does reclaim swap space on swap in.

Greetings
		Christoph


