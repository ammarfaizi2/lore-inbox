Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129902AbQLYOFK>; Mon, 25 Dec 2000 09:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbQLYOFB>; Mon, 25 Dec 2000 09:05:01 -0500
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:28567 "EHLO
	hermes.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S129902AbQLYOEr>; Mon, 25 Dec 2000 09:04:47 -0500
Date: Sun, 24 Dec 2000 17:23:37 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev@vuser.vu.union.edu>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: new linux_logo16
Message-ID: <Pine.LNX.4.10.10012241710170.1700-103000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-699396075-977675017=:1700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-699396075-977675017=:1700
Content-Type: TEXT/PLAIN; charset=US-ASCII


Since the 16-color logo was broken a while ago, we need a new one for 2.4.0.
The main limitation is that we no longer can choose the palette, but have to
use the standard VGA 16-color palette.

I quantized the 256-color logo to the VGA palette using ppmquant and used my
rudimentary artistical skills with the GIMP to remove the background pattern.
The results are attached (yes, they are small):
  - new_logo16.png: plain quantized 256-color logo
  - new_logo16_fs.png: quantized 256-color logo using Floyd-Steinberg dithering
  - new_logo16_2.png: new_logo16.png with the background pattern removed

So either some artistic soul creates a new non-offensive politically-correct[*]
logo using the standard VGA 16-color palette, or I'll submit new_logo16_2.png
for inclusion in 2.4.0.

Any comments?

Gr{oetje,eeting}s,

						Geert

[*] I don't want another to-drink-or-not-to-drink discussion.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--655616-699396075-977675017=:1700
Content-Type: APPLICATION/octet-stream; name="new_logo16.png"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10012241723370.1700@cassiopeia.home>
Content-Description: 
Content-Disposition: attachment; filename="new_logo16.png"

iVBORw0KGgoAAAANSUhEUgAAAFAAAABQBAMAAAB8P++eAAAAFVBMVEUAAABV
VVX//1Wqqqr/VVX///+qVQCgmcW3AAADCUlEQVR4nI2X224bIRBAByH7GYrs
D9go+7wUrT+glfpcd7V99iXi/z+hA8tlhsVpkKIEz/HcGJgJuLSswR/XWUkA
4XdYugcQQQHNKzD9At0SFgBE0MQF0JoMXCQbAbQWFWTyczAp1NB6FEGSlimB
SjaCCJJvq6yxFez2ZZkO6Hqg3PtoX4G2AfsamwR1QaHF/8GQIBPSuQcN3Yt5
ATGvC+rlghaUdgaxiLkDktCwsqQ+KX0VJ0w8F1DQYmVJMCB+w4GBQQCmlpPG
P6U6em8haOQCMJZ+z4mrH/x4X4FojAKSHhtUwOUx4BoBoBFUMNY++AgOioCb
YOH7o48KvYJautHZcgs3lxPoAyiZoAXBR86DeA3Gk4ALUv7DKWEFF+xuZQDD
3dHQCFoQVT7degXgF7EBJxGzsJWP/ARUco3cuiqa8j0Ip3Xj1qmxTUGrJ0DE
BS46KYugAQ3INa8AQgUtM23hUMCludsMVOhiWQAsHGYa3a+gAhYOBcNFnZPh
9K7JV+BcFLqFPxcUVCCq5XVWzEkKgjoQcJmYkwwklkMmhSBO0sslgHLrIlQf
nMi5pJSrGg0FmYttygnIzqWkfAdiRfBY8tnYrdcVEEuMx5JBrRuNkxA9UEaF
hvgIO3A77djYvwzSCQCE7ILtBIDdrwWVCGCSlwnACrUDaVXUJ+Ux9qJWu4R/
H4bbiXF/bl0Qn+QROxFZjwAe3ykYzId38SZ34LeBacQXLDzdN3baYwB/UNCa
+B6HXkDi+Tt6CE8/BV0CB1pp8elFATOdwVstteXy8NGhtx6IfehQwdHHz3sg
qsyBL2fUtjUnAv7K4L2A1+Mjf5hBPM3LUGznaNS5gG8djWOO5QoVfN9AS30c
nslDqOD4XieA8uXhPicut9lh/LnUCaBoHL0wsYgLiFydAC6+JNKXSSqCI3Yx
OgGk00qNOoGxz3643F1dLp94Xp6C4Whm104AWw1go057fQ67Zy5X2q8jd8+7
+bz1Y9dp7BYlvd0GkrncOE3bvC276GP3H4nI8e1uYH+1vgz+A8KVXqiUSTjn
AAAAAElFTkSuQmCC
--655616-699396075-977675017=:1700
Content-Type: APPLICATION/octet-stream; name="new_logo16_fs.png"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10012241723371.1700@cassiopeia.home>
Content-Description: 
Content-Disposition: attachment; filename="new_logo16_fs.png"

iVBORw0KGgoAAAANSUhEUgAAAFAAAABQBAMAAAB8P++eAAAAHlBMVEUAAABV
/1VVVVWqAAD//1Wqqqr/VVX///+qVQAAqgALscfPAAAEsklEQVR4nHVWzWrk
OBAuxJjkMTQGkT7uIwyD29HRiBbuB/BhjqGJ8TUEBXTe0z7u1q9sh10l6Y6t
T1/9VwkyrcS//Gdr/bYBqc85hBz6oAj+nnHzvAHMkhLvK2PaP/cNY2xSUwIA
lxujbUDQgyaVcIRM3zZYdAi7TA+GPGwQowDsRVLCHkLYN4iXX+hBej0p0Hcn
xsSMycxEpDfG0wZ6SXSUwwH/VEVcvVnHBMJ48F7DwZNKDqIpqCZ87gTsLHqi
KIgmLFi8yMI9O4g3UnPP8VwG5xCT+IMkJjMJ+Iz5CN1I5gSOTw4HSQhMqWUT
Ljev4OZtRcYgkdYgQjL/8GPo0gzd6mZkNPsk2GD2BsxB/LdzL75/4AdwzJJs
ILkwst5rwhztfOfdGzx5MiYLx5owlYA+VEJPjP5HjQmIMe2Z0qOOLe5MmN2j
DjV+rgRU3XEjsR+NMdEZuJc4DDGKe44bu2V0LrtSyoA/ntPnsHEAsk7PjItR
rc6WtxkelGzqxMBARNb4wVmxGylVqOdYlTogrlRwvmsly4y7ZCaGe601xqt3
k2sMDOzF/2Liml2uyJjnCatBFGKmNey2aZrl37Ve5+0NAPZaPVotbye33fCL
00drm4MoxXVoKL5b8XPD5aWxfGsp6hs897LNeSXgxLK5GhLZI1kntRp6lLxt
80zAh9QXxS/0BFS5gQvJE1AWAUEoWB6oD7NUzFMDkjWgdU3boCD2pkcV2+LW
Yu1LOkULPlIQF+m5MhDCgdHih6Zgas0qOOc3R+ZIT0NNYT14mwrVVl61XWgb
MEZi9+4A3GZPSDHSRHPvR3a/G43SJ1EySOTA8oOiBAdC8mTPPg9qdWgN0sF2
AvYou7N4cxWaLd0JuHH3sySElmNpEhXXk8vZz5TjoGFBV53iIpnmCBi4mYLC
MEt2W94NSGb30jzBAhhQ9e0seiJGSrKDw1GNybmz5I093iVzjxkDCjwyUrTD
wY+BQgP/x4i4nhpAkhD14Lr/ZEx2A2CbqCg4GU+MnGjBqlDHbXr2R9HE61G2
t9YkY5jULeW7MTzCzFhuUhSi91I+mmz2/PDRgOYeYr0PY+TQNMZCwOerZY/O
oxs20PJxSh8GXgada+LHe4xxHOKvU1rET6yZUrQCZLDHoSw4DQocDL+V6l0t
o45eAZYyDuMYh78OlCil1hLjI1mG5/CCfLgWlN1SbR3oVRyWa7YbAP5DjAvu
VGjlsJLeccRfdTg7B9UjaxZ0Xcd5+7ptl5E48fhgNwD8XlD2gOagocb4wNkw
EBZHhLoHVVBGnEXNGv9MzyilLK9ShdQw+A0yxGi2TFBZQ7QmLpq4xLiIOkv5
Ehx2jQu+WOh4fN1vAOSGkYMjlHRVqawfShl4vgJlzg1diHQjOyhQtuOqkfQb
STBVLFCTvLNvETvy/JV1GUm/WPAG0Ab7rdY/ZDQ6qDZgLaRfWankg5Xre+SZ
iqsaDvMBV73iZYYv2LDKoH8vlXZq1ZTO0z908svacW4theTj+tse5ws9rlIo
Sepab7z5fqmfX+0gPlUlbINdCyjkvrcGg58/P7/axn5V4Clx039UgvUvTbPT
nE/78D6+x/sd2OHAz/ulvB3Vc/8CrjeucY6t3cIAAAAASUVORK5CYII=
--655616-699396075-977675017=:1700
Content-Type: APPLICATION/octet-stream; name="new_logo16_2.png"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10012241723372.1700@cassiopeia.home>
Content-Description: 
Content-Disposition: attachment; filename="new_logo16_2.png"

iVBORw0KGgoAAAANSUhEUgAAAFAAAABQBAMAAAB8P++eAAAAFVBMVEUAAABV
VVX//1Wqqqr/VVX///+qVQCgmcW3AAACUUlEQVR4nL3XzY7bIBAA4Bmh5Dyu
lX0AInG2a9kP0JX2XNei58RZ8f6PUMAYAybB0lbLJYr9ZYDhZ3ahO9jgG2AL
AHgAGpeTO0iQlyl0ASuoC7BxkFgB0hoxfbH77lt9FLL/DvEAxArL0CSoNuks
QOwnwF5OkOYnhaztASfsy7C6UDXihYoQasDfcCpDOivVQjkijoorcZfFMcIw
c91EGSoLebHrs7IBFaXbJw+VgewlBGWdAizBQSv12RG2+Bp2BpqzU0EB6pCP
To7pYUhgg5P5WLYPewGJSeukpCTlaVovcnGySfqOYQOadMbZQbKnEJhcm4Hw
DLZw8nBKjmwESQ/RN4hDhlAfvXqDFN8rITQHtXcdu3uNPYO9D9hN8XURQgLc
epY9RYOMMkCnAE5NNMgIBj2bTCIGgwxgixA6OSHlYROsi0s5bbMJYTTENOUB
jNbFpzwDk7kka7NBnQ15DCLmINtB2MHmy5AdhJBCwixE2sH8rGeRmzXtEv6T
89slcn9uWaivZKErUdBmA8/XFJp78cZ28AePoL7BzNV9i1ZbGPgrhvY+NrUg
mM9focBc/TnIw51mr179Igtv21abhlnZAV1zUNeh0waFss9zUIdcJz696WhL
cQrgxwrvHo7neX0Ypof7vtfZ0JuH10xEsc5lhCz0Y+QPN0LYoAig/zG/986t
ZZaL99yshUK9ASvYoHMLHJRPpPJ/SVkodBWL8rislivUDto6+5nsR7uwsyvU
KzRL0yXQUVOoowePPXT9b2+GpR5noKVPv33HvwBfhf8AkSVu9jkJgkkAAAAA
SUVORK5CYII=
--655616-699396075-977675017=:1700--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
