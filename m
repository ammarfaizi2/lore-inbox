Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318497AbSH1Bdq>; Tue, 27 Aug 2002 21:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSH1Bdp>; Tue, 27 Aug 2002 21:33:45 -0400
Received: from imo-r09.mx.aol.com ([152.163.225.105]:14334 "EHLO
	imo-r09.mx.aol.com") by vger.kernel.org with ESMTP
	id <S318497AbSH1Bdo>; Tue, 27 Aug 2002 21:33:44 -0400
Message-ID: <3D6BF1E6.9010701@netscape.net>
Date: Tue, 27 Aug 2002 21:40:54 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>, greg@kroah.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.32 port PnP BIOS to the driver model RESEND #1
References: <3D5D7E50.4030307@netscape.net>	<20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net>	<20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net> <20020818214745.GA19556@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------040002040809020101060303"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------040002040809020101060303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As we discussed earlier, I converted the PnP BIOS driver to the driver 
model  Please advice on any changes you would like.  I look forward to 
hearing from you.

Thanks,
-Adam





The following are potential changes for future pnpbios patches listed in
order of priority.  Let me know if you support them.

1.) Add pnpbios specific interfaces to the driver model, this includes
resource management and escd.
2.) add pnpbios dev id list support, similiar to the devlist found in pci
3.) remove dependancy on struct pci_dev and create a pnpbios specific
dev structure
4.) split the pnpbios files into smaller more manageable files as well
as other cleanups
5.) port some drivers to use the pnpbios driver if available.  Should
this include the pci driver?


--------------040002040809020101060303
Content-Type: application/octet-stream;
 name="pnpbios1.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pnpbios1.patch.gz"

H4sICNbwaz0AA3BucGJpb3MxLnBhdGNoAL1YaXPbyBH9TP6KXm/FAUVQ4iFb1FmSbfmoyLJi
exOnNlsoEBiSE+FgcOhYl/97XvcMIJCiLCeV5ANJEN090+frnun1euRvhZm+Ulm+tUgW/Jno
NPeCNFObQetzqeiknNFwh4aDvVF/79mIhv3+sN3tdmnyb0iO9rYHRvL4mHqDbfc5dfE9puPj
NtEGEZ1EfkIv0xs68PF0nKlw7hebQRofWYbP8zT2c3qbpiEd/CMs5ng4jn0dNZleZBrLvIFS
BR1MZvx7HOowKcIyuNxMs9lRuwvGizQrVEhFSsVc0Ssxg96noYoIW1yrSH79MNSFThM/Ih0v
svRKxSopcnJedqwXsNTklk5CP6YXKvJvoXw8uRkcJ6rIA3+hNvEgqol6n+c6J6wzy8CPx2mm
FOXptLj2M7VPt2lJAbSH6TovMj0pC0W6ID8Jt9KM4jTU01u8kLXKJITKrH2hsjindCp/3pz/
AusTlUHni3IS6YDOdKCSXLFBC36Tz2E5tAa7BGP0nIMxGrs7EoyfdRJEZajoINJJebOF70t/
pjbnR/dplypLVLSWZNOBad1VWqiuoNOKmJ/HW4v7G/Hr/DYvVLx2m1heS04Nd9zBAFk16vMv
mwL2UE11oujP3qfTz/icOcGidClXUeLHyuUIZyrP8Ub/rjr09zZIhTfxc8WM3iwsvMKfROpX
/PvtV8fKdejoiEa/ueR5V77jlKNhx7ErdTqdfSzT42UiHevCefojC8n27e6d1I8LNa0c/m/M
XLHw/2/glqmfkwLVEitapDopUKV07eMXRVwivQsurrzwg0vUlV9xcY2AnlzrJJQ0GW+P3MGI
uuPt5+7guU0TiBWoFF5VJxG7UqNissIzmeqgGsugoEWg+Q1t4At6fW332r0WdOu1oNzrd1/e
n+7Ry7liDVCvmerBZVyY6gb1rJMZJUCYfcOeqaLMEqQt6am8Jz/KlB/eAiBUDpgRtq12t2U3
R+EW3hwcEF6k+f4dpVaLUHT8xDRhhxqe8oM5OZBw6WmF0casvPMVjC0rRIdmC2yd3Rr+5fVd
mkXpxI88ZuvwHi2o7oDSO8LXNKHDw0oD+6bDTK3aVJb5xv6G0+ivisI0+SMMS+GwiQp8jiKC
mibRLUgmoD5HBBhYaERU3GF09zI1gxoqc55W20ElMmbD7cgrHVlaQ+01PtgXhayO/X2TJDtj
d9BHkoy33eHQwCID7pRevj35WP95e/oFsu1unaAvSh2F5BNjJkCWd+T4WwfmMIXSjHEbL/0c
sBxWWUFJGU9UJqu89KMI0uKHpv2bTIULbFiMAeD3PGGBVBp4lXlZmhbOVapDxODrXa7UQjZN
TOAvYxF2uODSqbPBQe103DevL7w/nX48Pz2TcMcqRv0yze27y6xCzxcZKmhqMmJS5p4O3SfQ
50nHJmuwuDVEQaUnF8kFvXj34ZOhr8bVRLRbRcbo+42dbauVjatsn7Dj2cfscms26pNa5Vjc
C+/ayO720ee6u/2xnT3qIkLiiuMkGhumUpeoWF2I2HGaUv3U5GrgA5f5Grcv0OmBMofrosXm
YjEuqp9qdSwaOB0YVJUSpywbszsYc+veHaHzmSxtcZBW3Xx+IV52x1IhXO86HA29IvXk0WFT
ekdK5z5HTCTzKC08wWIREWOhSFpmCFHoFz5Lg1NkXRsqLvaqGDdrQ83D/hIRyQFKXYqcK8Xt
QglTM0+YV4y4pxQz2nR72lwWFvzaR+t48of+8OaJ24Ai41x411nGdlb+oC/ebV3yROZUWNJS
UW5GpN2dvjh695kdksxAt2WK3+bj2btPn723pyevnBpizHhsIMZyBWkCULhLqwYWQXesK/sB
dwa7mGX6g747sqG1hXD+y9kZFmQc7TX6lp8kaZlwdJZb1pIqyMzsahXXbTvrNhZrBib2i2Du
rIGPeh2rfbUFYY9l0LnXoBB8zj7zuq70B1Q2QlkltER1eC/BJtayst0K9I50aOYLt9q4iSh9
iyfrDLcmYVafqPu2x1X/f1Bn7L6uQQsuUOuxHNDhGlAp4oUVZ0Vhw75kXwXhTX/GlaUPei02
hSH/GrCz5LSOAGgLCh3SkntXXFuXiwCXIO9d0+8z5RtJJVWLmQzu4b8FK3pqjHNtWpnWsmx/
R/YwfJuNjr4JgLyqF13LkaibouaQo0If8D94xvW1veOOzBQo6kNrOqBBA2vFAmB5w2FYS1oM
bXRMnLc2vkMWlKird2BL9ztJl6kYJ811FfdfraoHc2MlM7pVZnQk4e/yxOhpRrzGC6dZaq27
ebDyjQkDD4LrKlF0rfoBrTYIiLMO3AP2WjJauFXt77XugRZo38SC0y8XHz7iXPS39y8+nDmr
ixoreYYzQ1zdk+0kUrmsR9UbTHiJuuYAkKGJ3DGcsCeHcCtgrCkzxUeQSrbdAytfHJgTTRjm
D4rw+2qErMQxF9quUt8qvMZZQ4Z8myoYMlnSmlG9lYWKOeZJ8Y3KMV9i1p7aghg+d4cjLogx
HrarWxl7qWDP60SnNwsVFEZjwUaaoufwFYkx0aQ4n2j4coEky8SuIPJ1nDcWIyfFn+xaY+bv
d1jn67mGDQHOpC5UzC7zuzWMhJ/T3L/igVlOBmblzWV/fhQVzEZmorbzt10kt9tcw5NGqfou
pBnKsMx4H+P0zGcDN/kCqo4TUt3HGNEMi7pSSdNy640rPyoVX/b8rrLUTvBLVb+SZt9p3ObI
+VBTKZNczxI+daRQfRr5s7xqFgEmA0ZAgbKuKVbrPi4lUOQVP++v0L8zqTXZTDIcru2fq7wG
Ju4zm/emGa0e40Q9HjUb57e74QqjoE48Pkd6Ovtn7gOEVo95QnWNWzo8m1f06ohcY6b4uB7C
qzUa6IhJHAwt49Tu4b3JS0YsA4A9QbnK/WaJ5sk1a0KtNaNMKkMwcBdp9qgtdW+RfaS/mJre
GeGM0x0MRtvVhViLj9/y+c+2YsTmIFXeWLGga3tbm9YjbpmsJLuZjO313Xggl8Kj7WrIFkUf
Pw1R7/T8w6vTv7B6nJ93/l2D9NRaPirKK96DfuLriIJPOSq7ujvt5GS3WnnNkqGeTqlXojX0
0A96Ux0BpbbsDeXWyj0oTR6itHtyDf8A9bE7+B8UG+1tDxsX8EM5BvNPlRqPD6Vm4Nvnyxtu
4gx2fAGX81m2xleGNwEdcjak/Dt4WgNZ7qMnIUySZi+02rq18ckNGCe7yJDlbNg5ZO0uWIGX
eGXEDWfoktLcfADz0mfnabGIypklk7lqL6OKf+kWbums0zI/XHIyQ9h72Nb6YwobDDhLkP2Y
bhkl1kK9a3ECgxXmVoX8fmwqkiL6WU/lfurD+et3bzx75gfhX8QPUxfjGQAA

--------------040002040809020101060303--
