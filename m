Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRA3RGP>; Tue, 30 Jan 2001 12:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbRA3RGF>; Tue, 30 Jan 2001 12:06:05 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:29962 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129752AbRA3RFz>;
	Tue, 30 Jan 2001 12:05:55 -0500
Date: Tue, 30 Jan 2001 09:06:05 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiplexing mouse input
In-Reply-To: <Pine.SOL.4.30.0101300017310.12047-100000@ultra1.inconnect.com>
Message-ID: <Pine.LNX.4.21.0101300905140.1857-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is this possible with the new "Input Drivers" in the 2.4 kernel?  Is
> it possible with Linux at all?

Yes. For X do this:

        Section "Pointer"
            Protocol    "ImPS/2"
            Device      "/dev/input/mice"
            ZAxisMapping 4 5
        EndSection



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
