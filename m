Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRCHV4s>; Thu, 8 Mar 2001 16:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCHV4i>; Thu, 8 Mar 2001 16:56:38 -0500
Received: from mail08.voicenet.com ([207.103.0.34]:18070 "HELO mail08")
	by vger.kernel.org with SMTP id <S129736AbRCHV4c>;
	Thu, 8 Mar 2001 16:56:32 -0500
Message-ID: <3AA80004.65259634@voicenet.com>
Date: Thu, 08 Mar 2001 16:56:20 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: incorrect CPU usage readings in 2.2.19prex?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there something generally wrong with how linux determines total cpu
usage (via procmeter3 and top) when dealing with applications that are
threaded?   I routinely get 0% cpu usage when playing mpegs and mp3s and
some avi's even (Divx when using no software enhancement) ... Somehow i
doubt that the decoders are so streamlined that they produce <1% cpu
usage on the computer.  Does anyone know what's going on with this?
ps shows nearly 0% cpu usage in the threads as well.
    i've seen it in these programs
        freeamp
        mplayer

I've seen it in earlier 2.2.19 kernels but i'm using pre14 right now.

