Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQJ3NcR>; Mon, 30 Oct 2000 08:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129048AbQJ3NcH>; Mon, 30 Oct 2000 08:32:07 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:44046 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129038AbQJ3Nby>; Mon, 30 Oct 2000 08:31:54 -0500
Date: Mon, 30 Oct 2000 14:27:39 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: vwbug <vwbug19@stratos.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.0-test9 nd bttv
Message-ID: <20001030142739.A29106@arthur.ubicom.tudelft.nl>
In-Reply-To: <39FCD671.A493E2F0@stratos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39FCD671.A493E2F0@stratos.net>; from vwbug19@stratos.net on Sun, Oct 29, 2000 at 09:01:21PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 09:01:21PM -0500, vwbug wrote:
> it look like you didn't add the lines to .config the stupid bttv drivers
> that's why mine didnt work with bttv card i have read the .config under
> video for linux  and found no refernce to bttv???

I'm not sure if this is what you mean, but you have to enable I2C
support and I2C bit-banging interfaces to be able to select BT848
support.


Erik
[happily using his BT848 card under 2.4.0-test10-pre3]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
