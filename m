Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272681AbRIPTUC>; Sun, 16 Sep 2001 15:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRIPTTw>; Sun, 16 Sep 2001 15:19:52 -0400
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:7652 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S272681AbRIPTTf>; Sun, 16 Sep 2001 15:19:35 -0400
Message-Id: <200109161919.f8GJJwA25036@smtp-server3.tampabay.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Phillip Susi <psusi@cfl.rr.com>
Reply-To: psusi@cfl.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Date: Sun, 16 Sep 2001 15:19:29 +0000
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.33L.0109161559500.21279-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109161559500.21279-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I'm missing something here, but it seems to me that these problems are 
due to the cache putting pressure on VM, so process pages get swapped out.  
The obvious solution to this is to limit the size of the cache, or implement 
some sort of algorithm to slow its growth and reduce the pressure on VM.  It 
also seems that one of the causes for the cache expanding is large bulk file 
copies, or reads for say, mp3 playing.  Wasn't there a flag to disable 
caching on file IO that these programs could use, to keep from polluting the 
cache?  

Am I way off base here?

-- 
--> Phill Susi
