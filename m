Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSD3QSF>; Tue, 30 Apr 2002 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313675AbSD3QSE>; Tue, 30 Apr 2002 12:18:04 -0400
Received: from netroute.netroute.cz ([62.40.73.2]:731 "HELO
	netroute.netroute.cz") by vger.kernel.org with SMTP
	id <S313638AbSD3QSD>; Tue, 30 Apr 2002 12:18:03 -0400
Date: Tue, 30 Apr 2002 18:21:34 +0200
From: Karel Kulhavy <clock@ghost.cybernet.cz>
To: linux-kernel@vger.kernel.org
Subject: GUS anti-noise hack
Message-ID: <20020430182134.C22103@ghost.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux GUS driver sometimes begins to make a white noise in right or left
channel. It is very annoying because it is very remarkable and is there for
every mp3 you listen to.

I have developped a hack how to get rid of it when it happens.

a:

cat /dev/urandom > /dev/dsp and wait for an audible chirp in the bad
channel. Then try to play some mp3. If noise persists, goto a;

It has worked for me already for two times and I spared myself two reboots :)

-- 
Karel 'Clock' Kulhavy
