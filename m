Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129531AbQJaMt0>; Tue, 31 Oct 2000 07:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbQJaMtQ>; Tue, 31 Oct 2000 07:49:16 -0500
Received: from odin.sinectis.com.ar ([216.244.192.22]:4363 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S129531AbQJaMtK>; Tue, 31 Oct 2000 07:49:10 -0500
Date: Tue, 31 Oct 2000 09:47:55 -0300
From: John R Lenton <john@grulic.org.ar>
To: linux-kernel@vger.kernel.org
Subject: oopsen in 2.4.0-pre9
Message-ID: <20001031094755.A1029@grulic.org.ar>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Several oops come up when using a lot of memory (using
imagemagick on PIA00001.tif from photojournal.jpl.nasa.gov/tiff,
on a 64MB machine, for example)

The weird thing is the oops happen *after* I've finished with
imagemagick (or the gimp, or ...). In this particular situation
netscape suddenly died, together with wmtime, and then the whole
of X hung. I entered via the network, to find that xfs had died
(explaining X's hanging), and as soon as I restarted X the whole
box was gone. It still responded to pings, but even the active
ssh session was dead and I couldn't get a new one.

Please email me if you need anything else (other than the
attached ksymoops output, that is).

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
1 + 1 = 3, for large values of 1.

--BXVAT5kNtrzKuDFl
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="oopsen.txt.gz"
Content-Transfer-Encoding: base64

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

--BXVAT5kNtrzKuDFl--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
