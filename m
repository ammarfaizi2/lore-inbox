Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285049AbRLQIfn>; Mon, 17 Dec 2001 03:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285054AbRLQIfc>; Mon, 17 Dec 2001 03:35:32 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:61627 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S285049AbRLQIfO> convert rfc822-to-8bit; Mon, 17 Dec 2001 03:35:14 -0500
From: Christoph Rohland <cr@sap.com>
To: RaXl NXXez de Arenas Coronado <raul@viadomus.com>
Cc: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: Is /dev/shm needed?
In-Reply-To: <E16FtLQ-00006A-00@DervishD.viadomus.com>
Organisation: SAP LinuxLab
Date: 17 Dec 2001 09:34:04 +0100
In-Reply-To: <E16FtLQ-00006A-00@DervishD.viadomus.com>
Message-ID: <m38zc2i6tf.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raúl,

On Mon, 17 Dec 2001, RaXl NXXez de Arenas Coronado wrote:
>>When one of these gets full I can either stop the affending job or
>>increase the limit
> 
>     That's one of my doubts: if the available RAM decreases then the
> buffer (disk) cache will do too. So, if I have /tmp mounted with
> tmpfs, the contents here will be cached no matter the available RAM,
> or am I completely wrong?

No, it will be swapped out.

Greetings
		Christoph


