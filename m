Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129417AbRBMMSj>; Tue, 13 Feb 2001 07:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbRBMMS3>; Tue, 13 Feb 2001 07:18:29 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:63365 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129417AbRBMMSK>; Tue, 13 Feb 2001 07:18:10 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: cowboy@vnet.ibm.com (Richard A Nelson), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre10
In-Reply-To: <E14SNMh-0007fo-00@the-village.bc.nu>
Organisation: SAP LinuxLab
In-Reply-To: <E14SNMh-0007fo-00@the-village.bc.nu>
Message-ID: <m3ofw7m240.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 13 Feb 2001 13:23:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, 12 Feb 2001, Alan Cox wrote:
>> First, I'm glad I wasn't hallucinating, and that the mail did
>> indeed get seen by someone.
>> 
>> Second, instead of reverting, can't we simply move those two lines
>> up a bit:
>
> Possibly but its a minor item that doesnt really matter anyway so leaving it
> is fine

No, I do not think that it's minor. We had to bring down running
application servers to be able to start another one, because the new
one couldn't create or attach the systemwide os-monitoring
segment and thus refused to start. That's very bad behaviour.

Greetings
		Christoph


