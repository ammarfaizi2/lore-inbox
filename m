Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279992AbRKNCKu>; Tue, 13 Nov 2001 21:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279993AbRKNCKa>; Tue, 13 Nov 2001 21:10:30 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:19979 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S279992AbRKNCKV>;
	Tue, 13 Nov 2001 21:10:21 -0500
Date: Wed, 14 Nov 2001 00:27:30 -0200
From: sergio@bruder.net
To: "Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio problems
Message-ID: <20011114002730.B1057@bruder.net>
Reply-To: sergio@bruder.net
Mail-Followup-To: sergio@bruder.net,
	"Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20011112220630.A1200@bruder.net> <20011113121907.A9058@telia.com> <004601c16c3c$8f865e70$1300a8c0@marcelo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <004601c16c3c$8f865e70$1300a8c0@marcelo>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 10:08:29AM -0200, Marcelo Borges Ribeiro wrote:
> The problem with via82xx is that it is locked in 48000Hz (you can see this
> in dmesg) and cannot play in any other rate. With mplayer you can see
> messages such as requested 16000Hz got (480000) that explains why it sounds
> like chip'n'dale ;-). P.s. I don´t know why it works with xmms  but with
> mpg123 it refuses to play at all becouse these sound rates.

That seems not to be my case. From a mplayer call (TNG episode, BTW :)):

audio_setup: using 11025 Hz samplerate (requested: 11025)

In my case the sound was ok until that assertion failed.


Sergio Bruder
--
http://pontobr.org, http://sergio.bruder.net, http://bruder.homeip.net:81
-----------------------------------------------------------------------------
pub  1024D/0C7D9F49 2000-05-26 Sergio Devojno Bruder <sergio@bruder.net>
     Key fingerprint = 983F DBDF FB53 FE55 87DF  71CA 6B01 5E44 0C7D 9F49
sub  1024g/138DF93D 2000-05-26
