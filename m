Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTCYGjP>; Tue, 25 Mar 2003 01:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCYGjP>; Tue, 25 Mar 2003 01:39:15 -0500
Received: from jk.sby.abo.fi ([130.232.136.104]:56068 "EHLO gemini.relay")
	by vger.kernel.org with ESMTP id <S261486AbTCYGjO>;
	Tue, 25 Mar 2003 01:39:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jan Knutar <jk@fornax.tk>
To: linux-kernel@vger.kernel.org
Subject: Re: Please send a reply to me....
Date: Tue, 25 Mar 2003 08:50:18 +0200
X-Mailer: KMail [version 1.2]
References: <F111KV6aGHW5uUJvf5w0000e9f0@hotmail.com>
In-Reply-To: <F111KV6aGHW5uUJvf5w0000e9f0@hotmail.com>
Cc: "Senthil Kumar" <senthil_gowran@hotmail.com>
MIME-Version: 1.0
Message-Id: <03032508501800.05216@polaris>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 March 2003 06:34, Senthil Kumar wrote:
> i. e. From the mp3 file i extracted the data to be played alone to my
> local buffer leaving the Frame information of 32 bits.
[ ... ]
> Then through ioctl() function i wrote the channel, bitrate and
> Format. Then through write function i wrote the data captured in the
> local buffer to the dsp device /dev/dsp.
[...]
> Is any uncompression should be done for data and written.
> Is so how the uncompression should be done..

The kernel doesn't do mp3 decoding, and yes, you have to decode mp3 
first into PCM. Take a look at mpg123 or xmms for ideas (google is your 
friend).
