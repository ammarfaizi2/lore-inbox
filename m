Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRKMP42>; Tue, 13 Nov 2001 10:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273902AbRKMP4I>; Tue, 13 Nov 2001 10:56:08 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8976 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273854AbRKMP4E>; Tue, 13 Nov 2001 10:56:04 -0500
Date: Tue, 13 Nov 2001 13:55:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux readahead setting?
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33L.0111131355030.20809-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Roy Sigurd Karlsbakk wrote:

> I heard linux does <= 32 page readahead from block devices
> (scsi/ide/que?). Is there a way to double this? I want to read 256kB
> chunks from the SCSI drives, as to get the best speed. These numbers are
> based on some testing and information I've got from Compaq's storage guys.

The -ac kernels have a way to tune this dynamically,
I guess we might want to push this change into 2.4
later on...

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

