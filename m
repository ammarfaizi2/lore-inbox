Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281062AbRKKOZC>; Sun, 11 Nov 2001 09:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281063AbRKKOYw>; Sun, 11 Nov 2001 09:24:52 -0500
Received: from pop.gmx.de ([213.165.64.20]:49810 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281062AbRKKOYm>;
	Sun, 11 Nov 2001 09:24:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Helge Deller <deller@gmx.de>
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>,
        linux-kernel@vger.kernel.org
Subject: Re: Teles isdn 16c plug and play
Date: Sun, 11 Nov 2001 15:24:00 +0100
X-Mailer: KMail [version 1.3.6]
In-Reply-To: <EXCH01SMTP01iCP3PLv0006143a@smtp.netcabo.pt>
In-Reply-To: <EXCH01SMTP01iCP3PLv0006143a@smtp.netcabo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011111142447Z281062-17408+13283@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 November 2001 15:01, Miguel Maria Godinho de Matos wrote:
> i am running red hat 7.2 with the 2.4.7 kernel, can someone tell me how can
> i configure my isdn card: teles isdn 16c plug and play ?
>
> This would be very appreciated thanks for your attention.
>
> Astinus

Hi Astinus,

Give it an io address and interrupt with the isapnp tools 
(preferrable io=0x580 and irq 5).
After that start the tool isdnconfig and use the HiSax 
ISDN driver type 14 (HFC-S based cards), e.g.:
options hisax io=0x580 irq=5 type=14 protocol=2

Greetings,
Helge

