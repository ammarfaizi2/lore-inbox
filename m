Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131858AbRAZPNy>; Fri, 26 Jan 2001 10:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRAZPNo>; Fri, 26 Jan 2001 10:13:44 -0500
Received: from gate.in-addr.de ([212.8.193.158]:55304 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S131858AbRAZPNi>;
	Fri, 26 Jan 2001 10:13:38 -0500
Date: Fri, 26 Jan 2001 16:13:38 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: James Sutherland <jas88@cam.ac.uk>
Cc: "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re:  hotmail not dealing with ECN
Message-ID: <20010126161338.N3849@marowsky-bree.de>
In-Reply-To: <14961.33191.626833.945221@pizda.ninka.net> <Pine.SOL.4.21.0101261506240.16539-100000@red.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <Pine.SOL.4.21.0101261506240.16539-100000@red.csi.cam.ac.uk>; from "James Sutherland" on 2001-01-26T15:08:21
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-01-26T15:08:21,
   James Sutherland <jas88@cam.ac.uk> said:

> Obviously. The connection is now dead. However, trying to make a new
> connection with different settings is perfectly reasonable.

No.

If connect() suddenly did two connection attempts instead of one, just how
many timeouts might that break?

> Why? The connection is dead, but there is nothing to prevent attempting
> another connection.

Right. And thats why connect() returns an error and retries are handled in
userspace.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
