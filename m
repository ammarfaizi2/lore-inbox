Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284117AbRLFPFN>; Thu, 6 Dec 2001 10:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284118AbRLFPFD>; Thu, 6 Dec 2001 10:05:03 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25093 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S284117AbRLFPEy> convert rfc822-to-8bit; Thu, 6 Dec 2001 10:04:54 -0500
Date: Thu, 6 Dec 2001 16:04:49 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011206160449.D8191@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <87d71s7u6e.fsf@bitch.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87d71s7u6e.fsf@bitch.localnet>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001, Daniel Stodden wrote:

> over the last few days, i've been experiencing lengthy syslog
> complaints like the following:
> 
> Dec  6 06:33:42 bitch kernel: hdc: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Dec  6 06:33:42 bitch kernel: hdc: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=1753708, sector=188216

> my main question is whether this could be a kernel problem or whether
> i just need to hurry a little getting my backups up to date and think
> about a new disk.

1. Get your backup done quickly, as long as the drive lasts.

2. Run IBM's drive fitness test. DO NOT USE "ERASE DISK" (low level
   format) features, no matter what IBM may say, check the
   German-Language DTLA FAQ: http://www.cooling-solutions.de/dtla-faq/
   Write down the technical result code. Also check Anandtech's FAQ
   (English language): http://www.anandtech.com/guides/viewfaq.html?i=71

3. (applies to Germany only, therefore in German, it's about where to ship
    the drive):
  a- Laufwerk < 6 Monate: Händler steht für alle Kosten ein, die durch
     den Defekt entstehen, Versandhändler müssen z. B. Porto erstatten

  b- Laufwerk > 6 Monate: von IBMs Webseite eine RAM anfordern, Laufwerk
     zu IBM einschicken, Frachtkosten gehen zu eigenen Lasten -- Versand
     war in meinem Fall in die Niederlande.

3.II: Make up your mind whether to ask the dealer or IBM (whichever
      applies) to replace the drive with one of another series. Usually,
      I'd to that, but that may not be feasible with RAID
      configurations. On a single drive, I'd even ask the dealer to
      replace with another brand, or IBM to replace a DTLA-3070xx with
      an IC35L0x0AVER07.
